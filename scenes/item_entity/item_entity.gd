class_name ItemEntity
extends Node2D

@onready var sprite : Sprite2D = %Sprite
var data : ItemData
var item_name : String
var base_price : float
var current_price : float
var categories : Array[ItemData.Category]
var company : ItemData.Company
var texture : Texture2D

func _ready():
	sprite.texture = data.texture

func get_current_discount() -> float:
	return base_price - current_price