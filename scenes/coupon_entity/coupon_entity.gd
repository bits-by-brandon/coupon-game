class_name CouponEntity
extends Control

const filter_group_scene := preload("res://scenes/coupon_entity/filter_label_group.tscn")

var tween : Tween
var data : CouponData
@onready var buttons : Container = %Buttons
@onready var use_button : Button = %UseButton
@onready var discard_button : Button = %DiscardButton
@export var hover_offset : Vector2 = Vector2(0, -40)

func _ready() -> void:
	%Filter.text = data.filters[0].get_label()
	%DiscountPrimary.text = data.discount.get_primary()
	%DiscountSuper.text = data.discount.get_super()
	%DiscountSub.text = data.discount.get_sub()

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _gui_input(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			Events.coupon_used.emit(self)
			accept_event()
		elif event.button_index == MOUSE_BUTTON_RIGHT && event.pressed:
			Events.coupon_discarded.emit(self)
			accept_event()

func _on_mouse_entered() -> void:
	if tween != null:
		tween.stop()

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", hover_offset, .6)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)

	tween.play()

func _on_mouse_exited() -> void:
	if tween != null:
		tween.stop()

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(), .3)\
		.set_trans(Tween.TRANS_QUART)\
		.set_ease(Tween.EASE_IN_OUT)

	tween.play()