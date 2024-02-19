class_name PercentageDiscount
extends Discount

static func create_random() -> Discount:
  var discount = PercentageDiscount.new()
  discount.value = float(randi_range(1, 4) * 10)
  return discount

func get_entity() -> CouponEntity:
  return preload("res://scenes/coupon_entity/coupon-static.tscn").instantiate()

func apply(item : ItemEntity) -> void:
  item.current_discount += (item.base_price * value * .01)

func get_primary() -> String:
  return str(value)

func get_super() -> String:
  return "%"

func get_sub() -> String:
  return "OFF"