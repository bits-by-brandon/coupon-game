extends Node2D

@onready var animation_player = %StickerAnimationPlayer

func _ready():
	Events.item_purchased.connect(_on_item_purchased)

func _on_item_purchased(item : ItemEntity, _coupons):
	await get_tree().create_timer(.2).timeout

	var percent_off := item.current_discount / item.base_price
	if percent_off > 1 || percent_off == 0:
		animation_player.play("full_price")
	elif percent_off == 1:
		animation_player.play("free")
	elif percent_off > .7:
		animation_player.play("great_deal")
	else:
		animation_player.play("good_deal")