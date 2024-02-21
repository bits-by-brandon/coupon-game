class_name EventBus
extends Node

signal game_started()
signal game_over()
signal item_scanned(item: ItemEntity)
signal item_purchased(item: ItemEntity, coupons_used : Array[CouponData])
signal streak_increased(new_streak: int)
signal streak_lost()
signal coupon_used(coupon: CouponEntity)
signal coupon_discarded(coupon: CouponEntity)
signal coupon_applied(coupon: CouponEntity, item : ItemEntity)
signal coupon_replenish_requested()
signal coupons_replenished()
signal discards_changed(discards: int)
signal explode_requested(position: Vector2)