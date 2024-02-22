extends Node2D

@onready var start_button : Button = %StartButton
@onready var instructions_button : Button = %InstructionsButton
@onready var close_instructions_button : Button = %CloseInstructionsButton
@onready var animation_player : AnimationPlayer = %GameAnimationPlayer

func _ready():
	start_button.pressed.connect(func(): 
		Events.reset.emit()
		animation_player.play("start_game"))

	instructions_button.pressed.connect(func(): 
		animation_player.play("show_instructions"))

	close_instructions_button.pressed.connect(func(): 
		animation_player.play("close_instructions"))

func start_game():
	Events.game_started.emit()
