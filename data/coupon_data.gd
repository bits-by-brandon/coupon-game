class_name CouponData
extends Resource

enum DiscountType {
  STATIC,
  PERCENTAGE,
  MULTIPLIER,
  FREE,
  BOGO,
}

@export var filters: Array[Filter] = []
@export var discount: Discount