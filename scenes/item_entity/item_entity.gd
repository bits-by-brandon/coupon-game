class_name ItemEntity
extends Node2D

const size := Vector2(120, 120)

@onready var sprite : Sprite2D = %Sprite
@onready var shadow : Sprite2D = %Shadow

var data : ItemData
var base_price : float = 0.0
var current_discount : float = 0.0

enum DISCOUNT_RATING {
	FULL_PRICE,
	GOOD,
	GREAT,
	FREE
}

func _ready():
	var sprite_scale := size.y / data.texture.get_size().y
	sprite.texture = data.texture
	sprite.scale = Vector2(sprite_scale, sprite_scale)
	sprite.offset = Vector2(0, -size.y * 2)

	base_price = data.base_price + round(randf_range(-data.price_variance, data.price_variance))

func get_discounted_price() -> float:
	return base_price - current_discount

func is_invalid() -> bool:
	return current_discount > base_price

func is_full_discount() -> bool:
	return current_discount == base_price

func get_discount_rating() -> DISCOUNT_RATING:
	var percent_off := current_discount / base_price
	if percent_off > 1 || percent_off == 0:
		return DISCOUNT_RATING.FULL_PRICE
	elif percent_off == 1:
		return DISCOUNT_RATING.FREE
	elif percent_off > .7:
		return DISCOUNT_RATING.GREAT
	else:
		return DISCOUNT_RATING.GOOD

func activate() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)\
		.tween_property(sprite, "position", Vector2(0, -40), 2)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)

	tween.tween_property(shadow, "scale", Vector2(0.3, 0.3), 2)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)

	tween.play()
