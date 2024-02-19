class_name StaticDiscount
extends Discount

static func create_random() -> Discount:
  var discount = StaticDiscount.new()
  discount.value = float(randi_range(2, 5))
  return discount

func apply(item : ItemEntity) -> void:
  item.current_discount += value

func get_primary() -> String:
  return "$%s" % [str(value)]

func get_super() -> String:
  return ".00"

func get_sub() -> String:
  return "OFF"