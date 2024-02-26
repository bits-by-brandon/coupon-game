extends Node2D

@onready var animation_player = %StickerAnimationPlayer

func _ready():
	Events.item_purchased.connect(_on_item_purchased)

func _on_item_purchased(item: ItemEntity, _coupons):
	await get_tree().create_timer(.2).timeout

	match item.get_discount_rating():
		ItemEntity.DISCOUNT_RATING.FULL_PRICE:
			animation_player.play("full_price")
		ItemEntity.DISCOUNT_RATING.FREE:
			animation_player.play("free")
		ItemEntity.DISCOUNT_RATING.GREAT:
			animation_player.play("great_deal")
		ItemEntity.DISCOUNT_RATING.GOOD:
			animation_player.play("good_deal")