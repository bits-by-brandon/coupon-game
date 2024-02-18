class_name CouponEntity
extends Control

signal clicked()

const filter_group_scene := preload("res://scenes/coupon_entity/filter_label_group.tscn")

var data : CouponData
@onready var filters : VBoxContainer = %Filters

func init(new_data : CouponData) -> void:
	data = new_data

	%DiscountPrimary.text = data.discount.get_primary()
	%DiscountSuper.text = data.discount.get_super()
	%DiscountSub.text = data.discount.get_sub()

	for filter: Filter in data.filters:
		var filter_group := filter_group_scene.instantiate() as FilterLabelGroup
		filters.add_child(filter_group)
		filter_group.init(filter)