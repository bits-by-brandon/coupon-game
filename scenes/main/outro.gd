extends Node2D

const receipt_list_item_scene = preload("res://scenes/receipt_list_item/receipt_list_item.tscn")
@onready var animation_player := %GameAnimationPlayer
@onready var receipt_list := %ReceiptList

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.game_over.connect(_on_game_over)

func _on_game_over():
	for transaction in State.transactions:
		var list_item = receipt_list_item_scene.instantiate()
		receipt_list.add_child(list_item)
		list_item.init(transaction)

	animation_player.play("show_score")