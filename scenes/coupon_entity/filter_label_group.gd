class_name FilterLabelGroup
extends VBoxContainer

@onready var filter_name: Label = %FilterName
@onready var filter_taxonomy: Label = %FilterTaxonomy

func init(filter: Filter) -> void:
	filter_name.text = filter.get_label()