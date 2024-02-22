extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.item_purchased.connect(_on_item_purchased)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_item_purchased(_item : ItemEntity, _coupons) -> void:
	print("bou")
