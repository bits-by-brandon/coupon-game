class_name PercentageDiscount
extends Discount

static func create_random() -> Discount:
  var discount = PercentageDiscount.new()
  discount.value = 50
  return discount

func get_entity() -> CouponEntity:
  return preload("res://scenes/coupon_entity/coupon_half.tscn").instantiate()

func apply(item : ItemEntity) -> void:
  item.current_discount += (item.base_price * value * .01)

func get_primary() -> String:
  return "50%"

func get_super() -> String:
  return "off"

func get_sub() -> String:
  return ""