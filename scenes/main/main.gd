class_name Main
extends Node

const down = preload("res://assets/sprites/cursorDown.png")
const up = preload("res://assets/sprites/cursor.png")

@onready var animation_player : AnimationPlayer = %GameAnimationPlayer

func _ready():
	Input.set_custom_mouse_cursor(up)
	animation_player.play("intro")

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			Input.set_custom_mouse_cursor(down)
		else:
			Input.set_custom_mouse_cursor(up)