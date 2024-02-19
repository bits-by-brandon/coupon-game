class_name EventBus
extends Node

signal item_scanned(item: ItemEntity)
signal coupon_used(coupon: CouponEntity)
signal coupon_discarded(coupon: CouponEntity)
signal coupon_applied(coupon: CouponEntity, item : ItemEntity)
signal busted()
signal coupon_replenish_requested()
signal coupons_replenished()
signal discards_changed(discards: int)
signal explode_requested(position: Vector2)