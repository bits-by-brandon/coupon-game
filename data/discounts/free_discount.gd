class_name FreeDiscount
extends Discount

static func create_random() -> Discount:
  var discount = MultiplyDiscount.new()
  discount.value = float(randi_range(2, 4))
  return discount

func apply(item : ItemEntity) -> float:
  return max(item.current_price, 0)

func get_primary() -> String:
  return "FREE"

func get_super() -> String:
  return ""

func get_sub() -> String:
  return ""