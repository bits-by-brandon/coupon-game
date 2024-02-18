class_name CouponManager
extends Node

@export var hand_size : int = 5
@onready var hand : Container = %Hand

# Called when the node enters the scene tree for the first time.
func _ready():
	for slot in hand.get_children():
		slot.get_child(0).queue_free()

	for i in range(hand_size):
		var coupon := create_random_coupon()
		hand.get_child(i).add_child(coupon)

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
		ColorFilter,
		ShapeFilter,
		PriceFilter,
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

