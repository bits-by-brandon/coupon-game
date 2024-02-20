extends Node2D

@onready var animation_player := %GameAnimationPlayer
@onready var receipt_list := %ReceiptList

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.game_over.connect(_on_game_over)

func _on_game_over():
	for transaction in State.transactions:
		pass

	animation_player.play("show_score")