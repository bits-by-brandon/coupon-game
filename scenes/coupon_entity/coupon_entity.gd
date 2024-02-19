class_name CouponEntity
extends Control

const filter_group_scene := preload("res://scenes/coupon_entity/filter_label_group.tscn")

var tween : Tween
var data : CouponData
var is_thrown : bool = false
var is_used : bool = false
var velocity : Vector2 = Vector2()
var angular_vel := 0.0
@onready var gravity := Vector2(0, 60)
@onready var animation : AnimationPlayer = %AnimationPlayer
@onready var card_sound : AudioStreamPlayer2D = %CardSound
@onready var left_button : CardButton = %LeftButton
@onready var right_button : CardButton = %RightButton
@export var hover_offset : Vector2 = Vector2(0, -40)
@export var throw_range : float = 1400.0
@export var throw_spin : float = 10.0

func _ready() -> void:
	if data != null:
		%DiscountPrimary.text = data.discount.get_primary()
		%DiscountSuper.text = data.discount.get_super()
		%DiscountSub.text = data.discount.get_sub()

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	left_button.clicked.connect(func (): Events.coupon_moved.emit(self, false))
	right_button.clicked.connect(func (): Events.coupon_moved.emit(self, true))
	Events.coupon_discarded.connect(func (coupon: CouponEntity): 
		if coupon == self: play_discard())

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
	Events.explode_requested.emit(%Inner.global_position + %Inner.size / 2)

func _process(delta):
	if is_thrown:
		velocity += gravity
		position += velocity * delta
		rotation += angular_vel * delta

func _gui_input(event : InputEvent):
	if is_thrown || is_used:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT && event.pressed:
			Events.coupon_discard_requested.emit(self)
			accept_event()

func _on_mouse_entered() -> void:
	if is_thrown || is_used:
		return

	%Buttons.visible = true

func _on_mouse_exited() -> void:
	if is_thrown || is_used:
		return

	%Buttons.visible = false