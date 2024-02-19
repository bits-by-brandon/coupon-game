class_name Hand
extends Control


# @onready var placeholders : Array[node] = %Placeholders.get_children()
# @onready var coupon_container : Container = %CouponContainer

# func _ready() -> void:
# 	Events.coupon_created.connect(_on_coupon_created)

# func _on_coupon_created(coupon: CouponInstance) -> void:
# 	var coupon_entity = preload("res://scenes/coupon_entity/coupon_entity.tscn").instantiate() as CouponEntity
# 	coupon_entity.instance = coupon
# 	coupon_container.add_child(coupon_entity)