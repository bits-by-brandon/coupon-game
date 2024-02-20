class_name CouponManager
extends Node

@export var hand_size : int = 5
@onready var hand : Container = %Hand

# Called when the node enters the scene tree for the first time.
func _ready():
	for slot in hand.get_children():
		slot.get_child(0).queue_free()

	Events.coupon_discarded.connect(_on_coupon_discarded)
	Events.coupon_applied.connect(_on_coupon_applied)
	Events.coupon_replenish_requested.connect(_on_coupon_replenish_requested)
	Events.game_started.connect(_on_game_started)

func _on_game_started() -> void:
	_on_coupon_replenish_requested()


func create_random_coupon() -> CouponEntity:
	var coupon_data := preload("res://data/coupon_data.gd").new()
	var discount := create_random_weighted_discount()
	var coupon_entity := discount.get_entity()

	coupon_data.discount = discount
	coupon_entity.data = coupon_data
	return coupon_entity

func create_random_weighted_discount() -> Discount:
	var discounts := [
		StaticDiscount,
		StaticDiscount,
		StaticDiscount,
		StaticDiscount,
		StaticDiscount,
		StaticDiscount,
		MultiplyDiscount,
		MultiplyDiscount,
		MultiplyDiscount,
		MultiplyDiscount,
		PercentageDiscount,
	]

	return discounts.pick_random().create_random()

func _on_coupon_discarded(coupon : CouponEntity):
	await get_tree().create_timer(.2).timeout

	var index = -1
	for slot in hand.get_children():
		if slot.get_child_count() > 0 && slot.get_child(0) == coupon:
			index = slot.get_index()
			break

	if index == -1:
		return

	coupon.queue_free()
	coupon.get_parent().remove_child(coupon)

	var new_coupon := create_random_coupon()
	new_coupon.visible = false
	hand.get_child(index).add_child(new_coupon)
	new_coupon.play_enter()

func _on_coupon_applied(coupon : CouponEntity, _item : ItemEntity):
	await get_tree().create_timer(.6).timeout

	var index = -1
	for slot in hand.get_children():
		if slot.get_child_count() > 0 && slot.get_child(0) == coupon:
			index = slot.get_index()
			break

	if index == -1:
		return

	coupon.queue_free()
	coupon.get_parent().remove_child(coupon)

func _on_coupon_replenish_requested():
	for slot in hand.get_children():
		if slot.get_child_count() == 0:
			var coupon := create_random_coupon()
			coupon.visible = false
			slot.add_child(coupon)
			coupon.play_enter()
			await get_tree().create_timer(.3).timeout
	
	Events.coupons_replenished.emit()
