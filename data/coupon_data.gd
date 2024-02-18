class_name CouponData
extends Resource

enum DiscountType {
  STATIC,
  PERCENTAGE,
  MULTIPLIER,
  FREE,
  BOGO,
}

@export var filters : Array[Filter] = []
@export var discount : Discount
# @export var discount_type : DiscountType
# @export var discount_value : float
# ## Used for BOGO
# @export var discount_secondary : float