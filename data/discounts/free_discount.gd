class_name FreeDiscount
extends Discount

static func create_random() -> Discount:
  var discount = FreeDiscount.new()
  return discount

func apply(item : ItemEntity) -> void:
  item.current_discount += item.base_price

func get_primary() -> String:
  return "FREE"

func get_super() -> String:
  return "100%"

func get_sub() -> String:
  return "OFF"