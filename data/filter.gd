class_name Filter
extends Resource

enum Operator {
  Max,
  Min
}

@export var colors : Array[ItemData.ItemColor]
@export var seasons : Array[ItemData.Season]
@export var expiration_value : int
@export var expiration_operator : Operator

static func create_random() -> Filter:
  assert(false, "Not implemented yet")
  return Filter.new()

func apply(entity: ItemEntity) -> bool:
  assert(false, "Not implemented yet")
  return false
  # if categories != null:
  #   if !any_in_array(entity.data.category, categories):
  #     return false
  
  # if companies != null:
  #   if !any_in_array(entity.data.company, companies):
  #     return false
  
  # if shapes != null:
  #   if !shapes.any(entity.shape):
  #     return false
  
  # if colors != null:
  #   if !colors.any(entity.color):
  #     return false
  
  # if price_value != null && price_operator != null:
  #   if price_operator == Operator.Max:
  #     if entity.price > price_value:
  #       return false
  #   else:
  #     if entity.price < price_value:
  #       return false
  
  # if seasons != null:
  #   if !any_in_array(entity.data.season, seasons):
  #     return false
  
  # if expiration_value != null && expiration_operator != null:
  #   if expiration_operator == Operator.Max:
  #     if entity.expiration > expiration_value:
  #       return false
  #   else:
  #     if entity.expiration < expiration_value:
  #       return false

  # return true
func get_label() -> String:
  return "Filter"

func get_subtext() -> String:
  return "Subtext"

func any_in_array(arrayA: Array, arrayB: Array) -> bool:
  for a in arrayA:
    for b in arrayB:
      if a == b:
        return true
  return false
