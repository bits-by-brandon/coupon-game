class_name PriceFilter
extends Filter

var operator : Filter.Operator
var price : float
static var value_min = 1
static var value_max = 10

static func create_random() -> Filter:
  var filter := PriceFilter.new()
  filter.price = float(randi_range(value_min, value_max))

  if randi_range(0, 1) == 0:
    filter.operator = Filter.Operator.Max  
  else: 
    filter.operator = Filter.Operator.Min

  return filter

func apply(entity: ItemEntity) -> bool:
  if operator == Filter.Operator.Max:
    return entity.current_price <= price
  else:
    return entity.current_price >= price

func get_label() -> String:
  if operator == Filter.Operator.Max:
    return "Items $%s or under" % str(price)
  else:
    return "Items $%s or over" % str(price)

func get_subtext() -> String:
  if operator == Filter.Operator.Max:
    return "Or under"
  else:
    return "Or over"