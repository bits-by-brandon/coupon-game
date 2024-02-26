class_name Register
extends Node2D

@onready var animation_player: AnimationPlayer = %RegisterAnimationPlayer
@onready var base_price_value: Label = %BasePriceValue
@onready var discount_price_value: Label = %DiscountPriceValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.item_scanned.connect(_on_item_scanned)
	Events.coupon_applied.connect(_on_coupon_applied)
	Events.reset.connect(_on_reset)

func _on_reset():
	base_price_value.text = "$0.00"
	discount_price_value.text = "$0.00"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_item_scanned(item: ItemEntity) -> void:
	animation_player.play("scan")
	base_price_value.text = "$%.02f" % [item.base_price]
	discount_price_value.text = "$%.02f" % [item.current_discount]

func _on_coupon_applied(_coupon: CouponEntity, item: ItemEntity) -> void:
	if item.get_discount_rating() == ItemEntity.DISCOUNT_RATING.FULL_PRICE:
		animation_player.play("coupon_full")
	else:
		animation_player.play("coupon_deal")

	base_price_value.text = "$%.02f" % [item.base_price]
	discount_price_value.text = "$%.02f" % [item.current_discount]