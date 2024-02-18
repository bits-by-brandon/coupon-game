class_name ItemEntity
extends Node2D

const size := Vector2(120, 120)
@onready var sprite : Sprite2D = %Sprite
var data : ItemData
var base_price : float = 0.0
var current_price : float = 0.0
var company : ItemData.Company

func _ready():
	sprite.texture = data.texture
	sprite.scale = size / data.texture.get_size()

	base_price = data.base_price + round(randf_range(-data.price_variance, data.price_variance))
	current_price = base_price
	company = data.valid_companies.pick_random()

func get_current_discount() -> float:
	return base_price - current_price
