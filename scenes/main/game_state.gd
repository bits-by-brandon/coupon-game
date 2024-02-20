class_name GameState
extends Node

var total := 0.0
var transactions : Array[Transaction] = []

func _ready():
  Events.game_started.connect(reset)
  Events.item_purchased.connect(_on_item_purchased)

func _on_item_purchased(item : ItemEntity, used_coupons : Array[CouponData]):
  add_transaction(item, used_coupons)

func add_transaction(item : ItemEntity, coupons : Array[CouponData]) -> void:
  var transaction := Transaction.new()
  transaction.item = item.data
  transaction.item_price = item.base_price
  transaction.total = item.base_price - item.current_discount
  transaction.coupons_used = coupons
  transaction.full_price = item.is_invalid()

  total += transaction.total

  transactions.append(transaction)
  print("Added transaction: ", transaction.item.name, " for ", transaction.item_price, " with ", transaction.total, " total")
  print(transactions)

func reset() -> void:
  total = 0
  transactions = []

class Transaction:
  var item : ItemData
  var item_price : float
  var total : float
  var coupons_used : Array[CouponData]
  var full_price : bool
