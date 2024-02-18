class_name ShapeFilter
extends Filter

@export var shape : ItemData.Shape

static func create_random() -> Filter:
  var filter := ShapeFilter.new()
  filter.shape = ItemData.Shape.values()[randi() % ItemData.Shape.size()]
  return filter

func apply(entity: ItemEntity) -> bool:
  return entity.data.shape == shape

func get_label() -> String:
  return "%s shaped items" % ItemData.Shape.keys()[shape].capitalize()

func get_subtext() -> String:
  return "Shaped items"
