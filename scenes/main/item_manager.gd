class_name ItemManager
extends Node

const item_entity := preload("res://scenes/item_entity/item_entity.tscn")	
const database := preload("res://data/main_database.tres")

@export var item_offset := 300
@export var item_count := 12
@export var belt_duration := 1.0
@onready var item_timer : Timer = %ItemTimer
@onready var items_container : Node2D = %Items

var ready_to_play : bool = false

var items : Array[ItemEntity]= []
@onready var scan_pos : Node2D = %ScanPosition
@onready var exit_pos : Node2D =	%ExitPosition
# Positions go right to left
var current_item : ItemEntity :
	set(value):
		if value == current_item: 
			return
		
		current_item = value

		if current_item != null:
			current_item.activate()
			Events.item_scanned.emit(value)
var coupons_used : Array[CouponData] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in item_count:
		var item := create_random_item()
		items.append(item)
		items_container.add_child(item)
		item.global_position = scan_pos.global_position - Vector2(i * item_offset, 0)
	

	item_timer.timeout.connect(_on_item_timer_finished)
	Events.coupon_used.connect(_on_coupon_used)
	Events.game_started.connect(_on_game_started)


func _on_game_started() -> void:
	await Events.coupons_replenished
	current_item = items[0]
	play()


func create_random_item() -> ItemEntity:
	var item = item_entity.instantiate()
	item.data = database.items.pick_random()
	return item

func cycle() -> void:
	if items.size() == 0:
		return

	coupons_used.clear()

	# TODO: Animate current_item to exit position
	var finished_item := items.pop_front() as ItemEntity
	finished_item.queue_free()

	for i in range(items.size()):
		var item = items[i]
		tween_item(item, scan_pos.global_position - Vector2(i * item_offset, 0))

	await get_tree().create_timer(belt_duration).timeout

	if items.size() > 0:
		current_item = items[0]
		item_timer.start()
		ready_to_play = true
	else:
		Events.game_over.emit()
		return

func tween_item(item : ItemEntity, target : Vector2) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(item, "global_position", target, belt_duration)\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_SPRING)

	tween.play()

func _on_item_timer_finished() -> void:
		purchase_item()

func _on_coupon_used(coupon : CouponEntity) -> void:
	if not ready_to_play:
		return

	coupon.data.discount.apply(current_item)
	Events.coupon_applied.emit(coupon, current_item)
	coupons_used.append(coupon.data)
	coupon.play_use()

	if current_item.current_discount >= current_item.base_price:
		purchase_item()

func purchase_item() -> void:
	Events.item_purchased.emit(current_item, coupons_used)
	pause()
	await get_tree().create_timer(1.0).timeout
	await replenish_coupons()
	cycle()
	
func pause() -> void:
	item_timer.stop()
	ready_to_play = false

func play() -> void:
	item_timer.start()
	ready_to_play = true

func replenish_coupons() -> void:
	Events.coupon_replenish_requested.emit()
	await Events.coupons_replenished
