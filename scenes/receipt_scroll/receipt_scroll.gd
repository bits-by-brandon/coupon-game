class_name ReceiptScroll
extends ScrollContainer

signal retry_pressed

const receipt_list_item_scene = preload("res://scenes/receipt_list_item/receipt_list_item.tscn")

@onready var receipt_list := %ReceiptList
@onready var receipt_scroll_inner : Container = %ReceiptScrollInner 
@onready var retry_button : Button = %RetryButton
@onready var audio_player : AudioStreamPlayer = %ReceiptAudioPlayer

func _ready():
	retry_button.pressed.connect(func(): retry_pressed.emit())
	Events.game_over.connect(_on_game_over)

func _on_game_over():
	for child in receipt_list.get_children():
		child.queue_free()

	var total_base := 0.0
	for transaction in State.transactions:
		var list_item = receipt_list_item_scene.instantiate()
		receipt_list.add_child(list_item)
		list_item.init(transaction)
		total_base += transaction.item_price
	
	%TotalSaved.text = "$%.2f" % [total_base - State.total]
	%FinalScore.text = str(State.score)

func animate():
	var inner_height := receipt_scroll_inner.get_rect().size.y
	var scroll_height := get_rect().size.y

	audio_player.play()

	var tween := get_tree().create_tween() 
	tween.tween_property(
		self, 
		"scroll_vertical", 
		inner_height - scroll_height, 
		8)
	tween.play()

	tween.finished.connect(func(): 
		audio_player.stop())
