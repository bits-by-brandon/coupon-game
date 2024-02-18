class_name ColorFilter
extends Filter

@export var color : ItemData.ItemColor

static func create_random() -> Filter:
  var filter := ColorFilter.new()
  filter.color = ItemData.ItemColor.values()[randi() % ItemData.ItemColor.size()]
  return filter

func apply(entity: ItemEntity) -> bool:
  return entity.data.colors.find(color) != -1

func get_label() -> String:
  return "%s colored items" % ItemData.ItemColor.keys()[color].capitalize()

func get_subtext() -> String:
  return "Colored items"
