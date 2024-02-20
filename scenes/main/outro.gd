extends Node2D

const print_sound = preload("res://assets/sfx/print.mp3")
const receipt_list_item_scene = preload("res://scenes/receipt_list_item/receipt_list_item.tscn")

@export var scroll_speed : float = 0.002

@onready var audio_player : AudioStreamPlayer = %GameAudioPlayer
@onready var animation_player : AnimationPlayer = %GameAnimationPlayer
@onready var receipt_list := %ReceiptList
@onready var receipt_scroll : ScrollContainer = %ReceiptScroll
@onready var receipt_scroll_inner : Container = %ReceiptScrollInner 

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.game_over.connect(_on_game_over)

func _on_game_over():
	for transaction in State.transactions:
		var list_item = receipt_list_item_scene.instantiate()
		receipt_list.add_child(list_item)
		list_item.init(transaction)

	animation_player.play("show_score")
	await animation_player.animation_finished
	await get_tree().create_timer(.4).timeout
	animate_receipt()

func animate_receipt():
	var inner_height := receipt_scroll_inner.get_rect().size.y
	var scroll_height := receipt_scroll.get_rect().size.y

	audio_player.volume_db = 0.0
	audio_player.stream = print_sound
	audio_player.play(0)

	var tween := get_tree().create_tween() 
	tween.tween_property(
		receipt_scroll, 
		"scroll_vertical", 
		inner_height - scroll_height, 
		5)
	tween.play()

	tween.finished.connect(func(): 
		audio_player.stop())
