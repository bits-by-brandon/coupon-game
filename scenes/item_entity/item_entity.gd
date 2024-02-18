class_name ItemEntity
extends RigidBody2D

@onready var sprite : Sprite2D = %Sprite
var body : Area2D

var item_name : String
var base_price : float
var current_price : float
var categories : Array[ItemData.Category]
var company : ItemData.Company
var texture : Texture2D

func init(item : ItemData):
	sprite.texture = item.texture

func get_current_discount() -> float:
	return base_price - current_price