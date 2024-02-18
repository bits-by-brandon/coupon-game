extends Node

@export var max_discards := 5

var total := 0.0
var discards := 0 :
	set(value):
		discards = value
		Events.discards_changed.emit(discards)
		%Discards.text = "Discards: %s" % [discards]

func _ready():
	Events.item_scanned.connect(_on_item_scanned)

func _on_item_scanned(_item) -> void:
	discards = max_discards