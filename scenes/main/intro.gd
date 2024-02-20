extends Node2D

@onready var start_button : Button = %StartButton
@onready var animation_player : AnimationPlayer = %GameAnimationPlayer

func _ready():
	start_button.pressed.connect(func(): 
		animation_player.play("start_game"))

func start_game():
	Events.game_started.emit()
