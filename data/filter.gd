class_name Filter
extends Resource

enum Operator {
  Max,
  Min
}

# @export var seasons : Array[ItemData.Season]
# @export var expiration_value : int
# @export var expiration_operator : Operator

static func create_random() -> Filter:
  assert(false, "Not implemented yet")
  return Filter.new()

func apply(_entity: ItemEntity) -> bool:
  assert(false, "Not implemented yet")
  return false

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
