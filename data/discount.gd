class_name Discount
extends Resource

var value : float

static func create_random() -> Discount:
  assert(false, "create_random() not implemented yet")
  return Discount.new()

func get_entity() -> CouponEntity:
  assert(false, "get_entity() not implemented yet")
  return preload("res://scenes/coupon_entity/coupon_entity.tscn").instantiate()

func apply(_item : ItemEntity) -> void:
  assert(false, "apply() not implemented yet")

func get_primary() -> String:
  return "$0"

func get_super() -> String:
  return ".00"

func get_sub() -> String:
  return "OFF"
