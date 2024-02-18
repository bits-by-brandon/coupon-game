class_name Discount
extends Resource

var value : float

static func create_random() -> Discount:
  assert(false, "create_random() not implemented yet")
  return Discount.new()

func apply(item : ItemEntity) -> float:
  assert(false, "apply() not implemented yet")
  return item.current_price

func get_primary() -> String:
  return "$0"

func get_super() -> String:
  return ".00"

func get_sub() -> String:
  return "OFF"