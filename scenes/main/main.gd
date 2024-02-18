extends Node

@onready var hand : Container = %Hand
@export var hand_size : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(hand_size):
		create_random_coupon()

func create_random_coupon() -> void:
	var coupon_entity := preload("res://scenes/coupon_entity/coupon_entity.tscn").instantiate()
	hand.add_child(coupon_entity)

	var coupon_data := preload("res://data/coupon_data.gd").new()
	# TODO Multiple filters
	coupon_data.filters = [create_random_filter()]
	coupon_data.discount = create_random_discount()

	coupon_entity.init(coupon_data)

func create_random_filter() -> Filter:
	var filters := [
		CategoryFilter,
		CompanyFilter
	] 

	return filters.pick_random().create_random()

func create_random_discount() -> Discount:
	var discounts := [
		StaticDiscount,
	]

	return discounts.pick_random().create_random()
