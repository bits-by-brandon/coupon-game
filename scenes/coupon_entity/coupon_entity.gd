class_name CouponEntity
extends Control

signal clicked(coupon: CouponEntity)

const filter_group_scene := preload("res://scenes/coupon_entity/filter_label_group.tscn")

var tween : Tween
var data : CouponData
@onready var filters : VBoxContainer = %Filters

func _ready() -> void:
	for child in filters.get_children():
		child.queue_free()

	%DiscountPrimary.text = data.discount.get_primary()
	%DiscountSuper.text = data.discount.get_super()
	%DiscountSub.text = data.discount.get_sub()

	for filter: Filter in data.filters:
		var filter_group := filter_group_scene.instantiate() as FilterLabelGroup
		filters.add_child(filter_group)
		filter_group.init(filter)

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _gui_input(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			clicked.emit(self)
			accept_event()

func _on_mouse_entered() -> void:
	if tween != null:
		tween.stop()

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0, -10), .6)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)

	tween.play()

func _on_mouse_exited() -> void:
	if tween != null:
		tween.stop()

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0, 0), .3)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)

	tween.play()