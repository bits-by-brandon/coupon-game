extends Node2D

@onready var animation_player: AnimationPlayer = %CashierAnimationPlayer

func _ready():
	Events.coupon_applied.connect(_on_coupon_applied)
	Events.item_scanned.connect(_on_item_scanned)

func _on_coupon_applied(_coupon: CouponEntity, item: ItemEntity):
	var percent_off := item.current_discount / item.base_price
	if percent_off > 1:
		animation_player.play("smug")
	elif percent_off == 1:
		animation_player.play("full_discount")
	elif percent_off > .7:
		animation_player.play("great_deal")
	elif percent_off > .5:
		animation_player.play("good_deal")

func _on_item_scanned(_item: ItemEntity):
	animation_player.play("idle")