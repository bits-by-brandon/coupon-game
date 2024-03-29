class_name ItemEntity
extends Node2D

const size := Vector2(120, 120)

@onready var sprite : Sprite2D = %Sprite
@onready var shadow : Sprite2D = %Shadow

var data : ItemData
var base_price : float = 0.0
var current_discount : float = 0.0
# var company : ItemData.Company

func _ready():
	sprite.texture = data.texture
	sprite.scale = size / data.texture.get_size()
	sprite.offset = Vector2(0, -size.y * 2)

	base_price = data.base_price + round(randf_range(-data.price_variance, data.price_variance))
	# company = data.valid_companies.pick_random()

func get_discounted_price() -> float:
	return base_price - current_discount

func activate() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)\
		.tween_property(sprite, "position", Vector2(0, -40), 3)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(shadow, "scale", Vector2(0.3, 0.3), 3)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_IN_OUT)

	tween.play()