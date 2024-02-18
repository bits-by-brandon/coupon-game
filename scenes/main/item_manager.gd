class_name ItemManager
extends Node

const item_entity := preload("res://scenes/item_entity/item_entity.tscn")	
const database := preload("res://data/main_database.tres")

@export var item_offset := 300
@export var item_count := 12
@onready var item_timer : Timer = %ItemTimer
@onready var items_container : Node2D = %Items

var items : Array[ItemEntity]= []
@onready var scan_pos : Node2D = %ScanPosition
@onready var exit_pos : Node2D =	%ExitPosition
# Positions go right to left
var current_item : ItemEntity :
	set(value):
		if value == current_item: 
			return
		
		current_item = value
		Events.item_scanned.emit(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in item_count:
		var item := create_random_item()
		items.append(item)
		items_container.add_child(item)
		item.global_position = scan_pos.global_position - Vector2(i * item_offset, 0)
	
	current_item = items[0]

	item_timer.timeout.connect(_on_item_timer_finished)
	Events.coupon_used.connect(_on_coupon_used)


func create_random_item() -> ItemEntity:
	var item = item_entity.instantiate()
	item.data = database.items.pick_random()
	return item

func cycle() -> void:
	if items.size() == 0:
		return

	# Animate current_item to exit position
	var finished_item := items.pop_front() as ItemEntity
	finished_item.queue_free()
	# TODO: trigger animation

	for i in range(items.size()):
		var item = items[i]
		tween_item(item, scan_pos.global_position - Vector2(i * item_offset, 0))

	if items.size() > 0:
		current_item = items[0]
	else:
		# Stop the cycle
		# TODO End game
		return

func tween_item(item : ItemEntity, target : Vector2) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(item, "global_position", target, 1.2)\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_SPRING)

	tween.play()

func _on_item_timer_finished() -> void:
	cycle()

func _on_coupon_used(coupon : CouponEntity) -> void:
	for filter : Filter in coupon.data.filters:
		if filter.apply(current_item):
			current_item.current_price = coupon.data.discount.apply(current_item)
			Events.coupon_applied.emit(coupon)
