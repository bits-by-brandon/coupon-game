class_name PercentageDiscount
extends Discount

static func create_random() -> Discount:
  var discount = PercentageDiscount.new()
  discount.value = float(randi_range(1, 8) * 10)
  return discount

func apply(item : ItemEntity) -> float:
  return item.current_price - (item.base_price * value)

func get_primary() -> String:
  return str(value)

func get_super() -> String:
  return "%"

func get_sub() -> String:
  return "OFF"