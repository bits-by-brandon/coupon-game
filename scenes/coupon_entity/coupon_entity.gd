class_name CouponEntity
extends Control

const filter_group_scene := preload("res://scenes/coupon_entity/filter_label_group.tscn")

var tween : Tween
var data : CouponData
var is_thrown : bool = false
var velocity : Vector2 = Vector2()
var angular_vel := 0.0
@onready var gravity := Vector2(0, 60)
@onready var animation : AnimationPlayer = %AnimationPlayer
@export var hover_offset : Vector2 = Vector2(0, -40)
@export var throw_range : float = 1400.0
@export var throw_spin : float = 1.0

func _ready() -> void:
	%Filter.text = data.filters[0].get_label()
	%DiscountPrimary.text = data.discount.get_primary()
	%DiscountSuper.text = data.discount.get_super()
	%DiscountSub.text = data.discount.get_sub()

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func play_error() -> void:
	animation.play("error")

func play_discard() -> void:
	if tween != null:
		tween.stop()
	
	if animation.current_animation != "RESET":
		animation.play("RESET")

	velocity = Vector2(randf_range(-.3, .3), -1).normalized() * throw_range
	angular_vel = randf_range(throw_spin, -throw_spin)
	is_thrown = true
	# animation.play("discard")

func _process(delta):
	if is_thrown:
		velocity += gravity
		global_position += velocity * delta
		rotation += angular_vel * delta


func _gui_input(event : InputEvent):
	if is_thrown:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			Events.coupon_used.emit(self)
			accept_event()
		elif event.button_index == MOUSE_BUTTON_RIGHT && event.pressed:
			Events.coupon_discarded.emit(self)
			play_discard()
			accept_event()

func _on_mouse_entered() -> void:
	if is_thrown:
		return

	if tween != null:
		tween.stop()

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", hover_offset, .6)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)

	tween.play()

func _on_mouse_exited() -> void:
	if is_thrown:
		return

	if tween != null:
		tween.stop()

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(), .3)\
		.set_trans(Tween.TRANS_QUART)\
		.set_ease(Tween.EASE_IN_OUT)

	tween.play()
