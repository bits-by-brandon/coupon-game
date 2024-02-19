class_name CouponEntity
extends Control

const filter_group_scene := preload("res://scenes/coupon_entity/filter_label_group.tscn")

var is_thrown : bool = false
var is_used : bool = false
var is_pressed : bool = false
var is_dragging : bool = false
var drag_start_x : float = 0.0

var tween : Tween
var data : CouponData
var velocity : Vector2 = Vector2()
var angular_vel := 0.0
@onready var gravity := Vector2(0, 60)
@onready var animation : AnimationPlayer = %AnimationPlayer
@onready var inner : Control = %Inner
@onready var card_sound : AudioStreamPlayer2D = %CardSound
@export var hover_offset : Vector2 = Vector2(0, -40)
@export var throw_range : float = 1400.0
@export var throw_spin : float = 10.0

func _ready() -> void:
	if data != null:
		%Filter.text = data.filters[0].get_label()
		%DiscountPrimary.text = data.discount.get_primary()
		%DiscountSuper.text = data.discount.get_super()
		%DiscountSub.text = data.discount.get_sub()

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func play_error() -> void:
	animation.play("error")

func play_enter() -> void:
	animation.play("enter")
	
func play_use() -> void:
	animation.play("use")
	is_used = true

func play_discard() -> void:
	if is_used:
		return

	if tween != null:
		tween.stop()
	
	if animation.current_animation != "RESET":
		animation.play("RESET")
		animation.play("discard")

	velocity = Vector2(randf_range(-.3, .3), -1).normalized() * throw_range
	angular_vel = randf_range(throw_spin, -throw_spin)
	is_thrown = true
	card_sound.play()

func request_explosion() -> void:
	Events.explode_requested.emit(inner.global_position + %Inner.size / 2)

func _process(delta):
	if is_thrown:
		velocity += gravity
		position += velocity * delta
		rotation += angular_vel * delta

func _gui_input(event : InputEvent):
	if is_thrown || is_used:
		return

	if event is InputEventMouseMotion:
		if is_pressed:
			print("dragging")
			is_dragging = true
			
			# Dragging
			inner.position += event.relative

			var drag_x_distance = drag_start_x - get_global_mouse_position().x
			if drag_x_distance > size.x / 2:
				Events.coupon_dragged.emit(self, true)
			if drag_x_distance < -size.x / 2:
				Events.coupon_dragged.emit(self, true)

			accept_event()

	elif event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_pressed = true
				drag_start_x = get_global_mouse_position().x
				z_index = 1
				print('setting drag start', drag_start_x)

			elif event.is_released():
				is_pressed = false
				if is_dragging:
					is_dragging = false
					z_index = 0
				else:
					Events.coupon_used.emit(self)
			accept_event()

		elif event.button_index == MOUSE_BUTTON_RIGHT && event.pressed:
			Events.coupon_discarded.emit(self)
			play_discard()
			accept_event()


func _on_mouse_entered() -> void:
	if is_thrown || is_used || is_pressed || is_dragging:
		return

	if tween != null:
		tween.stop()

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", hover_offset, .6)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)

	tween.play()

func _on_mouse_exited() -> void:
	if is_thrown || is_used || is_pressed || is_dragging:
		return

	if tween != null:
		tween.stop()

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(), .3)\
		.set_trans(Tween.TRANS_QUART)\
		.set_ease(Tween.EASE_IN_OUT)

	tween.play()
