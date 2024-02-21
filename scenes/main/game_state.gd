class_name GameState
extends Node

var score := 0.0
var total := 0.0

@export var streak_threshold := 3
@export var streak_multiplier_max := 5
var streak := 0
var streak_multiplier = 1

var transactions : Array[Transaction] = []

func _ready():
  Events.game_started.connect(reset)
  Events.item_purchased.connect(_on_item_purchased)

func _on_item_purchased(item : ItemEntity, coupons : Array[CouponData]) -> void:
  var discount_rating := item.get_discount_rating()
  if discount_rating == ItemEntity.DISCOUNT_RATING.FULL_PRICE:
    streak = 0
    streak_multiplier = 1
    Events.streak_lost.emit()
  else:
    streak += 1
    if streak % streak_threshold == 0 && streak_multiplier < streak_multiplier_max:
      streak_multiplier += 1
      Events.streak_increased.emit(streak)

  var transaction := Transaction.new()
  transaction.item = item.data
  transaction.item_price = item.base_price
  transaction.coupons_used = coupons.duplicate()
  transaction.full_price = discount_rating == ItemEntity.DISCOUNT_RATING.FULL_PRICE
  transaction.total = item.base_price - item.current_discount
  transaction.score = calculate_score(item)
  total += transaction.total
  score += transaction.score

  transactions.append(transaction)


func calculate_score(item : ItemEntity) -> float:
  match item.get_discount_rating():
    ItemEntity.DISCOUNT_RATING.FREE:
      return 1.5 * streak
    ItemEntity.DISCOUNT_RATING.GREAT:
      return 1.2 * streak
    ItemEntity.DISCOUNT_RATING.GOOD:
      return 1.0 * streak
    ItemEntity.DISCOUNT_RATING.FULL_PRICE, _:
      return 0.0


func reset() -> void:
  total = 0
  transactions.clear()


class Transaction:
  var item : ItemData
  var item_price : float
  var total : float
  var coupons_used : Array[CouponData]
  var full_price : bool
  var score : float
