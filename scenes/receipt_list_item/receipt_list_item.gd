class_name ReceiptListItem
extends VBoxContainer

const line_item_scene := preload("res://scenes/receipt_list_item/line_item.tscn")
@onready var line_item_container : VBoxContainer = %LineItems

# Called when the node enters the scene tree for the first time.
func _init(transaction : GameState.Transaction):
	for coupon in transaction.coupons_used:
		var line_item = line_item_scene.instantiate()
		line_item.set_label("Something")
		line_item.set_value("$10.00")
		line_item_container.add_child(line_item)
	
	%ItemIcon.texture = transaction.item.texture
	%NameLabel.text = transaction.item.name
	%DiscountsAppliedLabel.text = "NO" if transaction.full_price else "YES"
	%BasePriceLabel.text = "$%.2f" % [transaction.base_price]
	%FinalPriceLabel.text = "$%.2f" % [transaction.final_price]

