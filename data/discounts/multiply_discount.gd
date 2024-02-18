class_name MultiplyDiscount
extends Discount

static func create_random() -> Discount:
  var discount = MultiplyDiscount.new()
  discount.value = float(randi_range(2, 4))
  return discount

func apply(item : ItemEntity) -> void:
  item.current_discount *= value

func get_primary() -> String:
  return "x%s" % [str(value)]

func get_super() -> String:
  return "Current"

func get_sub() -> String:
  return "Discount"