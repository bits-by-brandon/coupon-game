extends Node2D

@onready var animation_player = %StickerAnimationPlayer

func _ready():
	Events.item_purchased.connect(_on_item_purchased)

func _on_item_purchased(item : ItemEntity, _coupons):
	await get_tree().create_timer(.2).timeout
	if item.is_invalid() || item.current_discount == 0:
		animation_player.play("full_price")
	elif item.is_full_discount():
		animation_player.play("full_discount")
	else:
		animation_player.play("good_deal")
