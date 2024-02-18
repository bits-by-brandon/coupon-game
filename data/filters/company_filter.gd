class_name CompanyFilter
extends Filter

@export var company : ItemData.Company

static func create_random() -> Filter:
  var filter := CompanyFilter.new()
  filter.company = ItemData.Company.values()[randi() % ItemData.Company.size()]
  return filter

func apply(entity: ItemEntity) -> bool:
  return entity.data.company == company

func get_label() -> String:
  return ItemData.Company.keys()[company].capitalize()

func get_subtext() -> String:
  return "Brand items"