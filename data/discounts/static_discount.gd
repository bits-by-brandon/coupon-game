class_name StaticDiscount
extends Discount

static func create_random() -> Discount:
  var discount = StaticDiscount.new()
  discount.value = float(randi_range(1, 20))
  return discount

func apply(item : ItemEntity) -> void:
  item.current_discount += value

func get_primary() -> String:
  return "+$%.2f" % [value]

func get_super() -> String:
  return "Discount"

func get_sub() -> String:
  return ""