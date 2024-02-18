extends Node

const database := preload("res://data/main_database.tres")
const item_entity := preload("res://scenes/item_entity/item_entity.tscn")	


@export var hand_size : int = 5
@onready var hand : Container = %Hand

@export var item_count := 12
@onready var items_in_queue = item_count - 5

@onready var items_container : Node2D = %Items

var items : Array[ItemEntity]= []
@onready var exit_pos : Node2D =	%ExitPosition
# Positions go right to left
@onready var position_map : Dictionary = {
	0 : %Position0,
	1 : %Position1,
	2 : %Position2,
	3 : %Position3,
	4 : %Position4
}
var current_item : ItemEntity

@onready var item_timer : Timer = %ItemTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	for slot in hand.get_children():
		slot.get_child(0).queue_free()

	for i in range(hand_size):
		var coupon := create_random_coupon()
		coupon.clicked.connect(_on_coupon_clicked)
		hand.get_child(i).add_child(coupon)
	
	for pos : Node in position_map.values():
		var item := create_random_item()
		items.append(item)
		items_container.add_child(item)
		print(pos.global_position)
		item.global_position = pos.global_position
	
	current_item = items[0]

	item_timer.timeout.connect(_on_item_timer_finished)

func cycle() -> void:
	print("Cycling ", items_in_queue)

	if items_in_queue > 0:
		# Add new item in entry position
		var new_item = create_random_item()
		new_item.global_position = position_map[items.size() - 1].global_position
		items.append(new_item)
		items_container.add_child(new_item)

	# Animate current_item to exit position
	var finished_item := items.pop_front() as ItemEntity
	finished_item.queue_free()
	# TODO: trigger animation

	current_item = items[0]
	# TODO: Set current item details in register

	for i in range(items.size()):
		var item = items[i]
		tween_item(item, position_map[i].global_position)

	items_in_queue -= 1

	if items.size() == 0:
		# TODO End game
		return # Stop the cycle

func tween_item(item : ItemEntity, target : Vector2) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(item, "global_position", target, 1.2)\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_SPRING)

	tween.play()

func _on_coupon_clicked(coupon : CouponEntity):
	print(coupon)

func create_random_coupon() -> CouponEntity:
	var coupon_entity := preload("res://scenes/coupon_entity/coupon_entity.tscn").instantiate()
	var coupon_data := preload("res://data/coupon_data.gd").new()
	# TODO Multiple filters
	coupon_data.filters = [create_random_filter()]
	coupon_data.discount = create_random_discount()
	coupon_entity.data = coupon_data
	return coupon_entity

func create_random_filter() -> Filter:
	var filters := [
		CategoryFilter,
		CompanyFilter,
		ShapeFilter,
		PriceFilter,
		ColorFilter,
	] 

	return filters.pick_random().create_random()

func create_random_discount() -> Discount:
	var discounts := [
		StaticDiscount,
		PercentageDiscount,
		MultiplyDiscount,
		FreeDiscount,
	]

	return discounts.pick_random().create_random()

func create_random_item() -> ItemEntity:
	var item = item_entity.instantiate()
	item.data = database.items.pick_random()
	return item

func _on_item_timer_finished() -> void:
	cycle()
