extends Node2D

const size := Vector2(150, 150)
@onready var path_follow: PathFollow2D = %BagPathFollow
@onready var sprite: Sprite2D = %BaggedItem
@onready var animation_player: AnimationPlayer = %BagAnimationPlayer

func _ready():
	Events.item_bagged.connect(_on_item_bagged)

func _on_item_bagged(item: ItemEntity) -> void:
	var sprite_scale := size.y / item.data.texture.get_size().y
	sprite.texture = item.data.texture
	sprite.scale = Vector2(sprite_scale, sprite_scale)
	sprite.offset = Vector2(0, -size.y * 2)

	var tween := get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_method(func(ratio: float) -> void:
		path_follow.progress_ratio=ratio
		sprite.global_position=path_follow.global_position,
		0.0, 1.0, 1.2) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN)

	tween.play()
	animation_player.play("item_bagged")