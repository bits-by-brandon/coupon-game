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

	Events.coupon_discarded.connect(_on_coupon_discarded)
	Events.coupon_applied.connect(_on_coupon_applied)
	Events.coupon_moved.connect(_on_coupon_moved)
	%CheckoutButton.pressed.connect(_on_checkout_pressed)

func create_random_coupon() -> CouponEntity:
	var coupon_entity := preload("res://scenes/coupon_entity/coupon_entity.tscn").instantiate()
	var coupon_data := preload("res://data/coupon_data.gd").new()
	coupon_data.discount = create_random_discount()
	coupon_entity.data = coupon_data
	return coupon_entity

func create_random_discount() -> Discount:
	var discounts := {
		StaticDiscount : 3,
		MultiplyDiscount : 2,
		BasePercentDiscount : 1,
	}

	var total_weight := 0
	for weight in discounts.values():
		total_weight += weight

	var selection = randi_range(0, total_weight)
	for discount in discounts.keys():
		selection -= discounts[discount]
		if selection <= 0:
			return discount.create_random()

	return StaticDiscount.create_random()

func _on_coupon_discarded(coupon : CouponEntity):
	await get_tree().create_timer(0.6).timeout

	var index = find_index_of_coupon(coupon)
	if index == -1:
		return

	coupon.queue_free()
	coupon.get_parent().remove_child(coupon)

	var new_coupon := create_random_coupon()
	hand.get_child(index).add_child(new_coupon)
	new_coupon.play_enter()

func _on_coupon_applied(coupon : CouponEntity, _item : ItemEntity):
	await get_tree().create_timer(.6).timeout

	var index = find_index_of_coupon(coupon)
	if index == -1:
		return

	coupon.queue_free()
	coupon.get_parent().remove_child(coupon)

func _on_coupon_moved(coupon : CouponEntity, right: bool):
	var index = find_index_of_coupon(coupon)
	if index == -1: return
	if index == 0 && !right: return
	if index == hand.get_child_count() - 1 && right: return
	
	var current_slot = hand.get_child(index)
	var next_slot
	if right:
		next_slot = hand.get_child(index + 1)
	else:
		next_slot = hand.get_child(index - 1)
	var next_coupon = next_slot.get_child(0)

	next_slot.remove_child(next_coupon)
	current_slot.remove_child(coupon)
	next_slot.add_child(coupon)
	current_slot.add_child(next_coupon)

func find_index_of_coupon(coupon : CouponEntity) -> int:
	for slot in hand.get_children():
		if slot.get_child(0) == coupon:
			return slot.get_index()
	return -1

func get_coupons() -> Array:
	var coupons := []
	for slot in hand.get_children():
		if slot.get_child_count() > 0:
			coupons.append(slot.get_child(0))
	return coupons

func _on_checkout_pressed() -> void:
	for coupon in get_coupons():
		Events.coupon_used.emit(coupon)
		await get_tree().create_timer(.4).timeout