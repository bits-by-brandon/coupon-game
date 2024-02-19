class_name GameState
extends Node

var total := 0.0
var transactions : Array[Transaction] = []

func add_transaction(item : ItemEntity, coupons : Array[CouponData]) -> void:
  var transaction := Transaction.new()
  transaction.item = item.data
  transaction.item_price = item.base_price
  transaction.coupons_used = coupons
  total += item.base_price - item.current_discount

  transactions.append(transaction)
  print("Transactions: ", transactions)
  print("Total: ", total)

func reset() -> void:
  total = 0

class Transaction:
  var item : ItemData
  var item_price : float
  var coupons_used : Array[CouponData]
