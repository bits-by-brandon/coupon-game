class_name CategoryFilter
extends Filter

var category : ItemData.Category

static func create_random() -> Filter:
  var filter := CategoryFilter.new()
  filter.category = ItemData.Category.values()[randi() % ItemData.Category.size()]
  return filter

func apply(entity: ItemEntity) -> bool:
  return entity.data.categories.find(category) != -1

func get_subtext() -> String:
  return "Products"

func get_label() -> String:
  return ItemData.Category.keys()[category].to_pascal_case()
