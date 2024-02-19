class_name BasePercentDiscount
extends Discount

static func create_random() -> Discount:
  var discount = BasePercentDiscount.new()
  discount.value = float(randi_range(1, 8) * 10)
  return discount

func apply(item : ItemEntity) -> void:
  item.current_discount += (item.base_price * value * .01)

func get_primary() -> String:
  return "+" + str(value) + "%"

func get_super() -> String:
  return "base price"

func get_sub() -> String:
  return "as discount"