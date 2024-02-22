extends Node2D

@export var scroll_speed : float = 0.003

@onready var audio_player : AudioStreamPlayer = %GameAudioPlayer
@onready var animation_player : AnimationPlayer = %GameAnimationPlayer
@onready var receipt_scroll : ReceiptScroll = %ReceiptScroll

func _ready():
	receipt_scroll.retry_pressed.connect(_on_retry_pressed)
	Events.game_over.connect(_on_game_over)

func _on_game_over():
	animation_player.play("show_score")
	await animation_player.animation_finished
	await get_tree().create_timer(.4).timeout
	receipt_scroll.animate()

func _on_retry_pressed():
	animation_player.play("close_score")
	await animation_player.animation_finished
	animation_player.play("intro")

