class_name ReceiptListItem
extends VBoxContainer

const line_item_scene := preload ("res://scenes/receipt_list_item/line_item.tscn")
@onready var line_item_container: VBoxContainer = %LineItems

# Called when the node enters the scene tree for the first time.
func init(transaction: GameState.Transaction):
  for line_item in line_item_container.get_children():
    line_item.queue_free()

  for coupon in transaction.coupons_used:
    var line_item = line_item_scene.instantiate()
    line_item_container.add_child(line_item)
    line_item.set_label([
      "Expired coupon",
      "Crumpled coupon",
      "Smelly coupon",
      "Smudged coupon",
      "Probably fake coupon",
      "Loyalty card",
      "Photocopied coupon",
      "Newspaper cutout",
      "Magazine cutout",
      "Online promo code",
      "Bribe"
    ].pick_random())

    if coupon.discount is StaticDiscount:
      line_item.set_value("$%s" % [coupon.discount.value])
    elif coupon.discount is PercentageDiscount:
      line_item.set_value(str(coupon.discount.value) + "%")
    elif coupon.discount is MultiplyDiscount:
      line_item.set_value("x%s" % [coupon.discount.value])
    else:
      line_item.set_value("%s" % [coupon.discount.value])
  
  %ItemIcon.texture = transaction.item.texture
  %ItemNameLabel.text = transaction.item.name
  %BasePriceLabel.text = "$%.2f" % [transaction.item.base_price]
  %FinalPriceLabel.text = "$%.2f" % [
    transaction.item.base_price \
    if transaction.full_price else \
    transaction.total]
  %ItemScoreLabel.text = str(transaction.score)

  match transaction.discount_rating:
    ItemEntity.DISCOUNT_RATING.FREE:
      %Sticker.texture = preload ("res://assets/sprites/stickers/stickerRAINBOW.png")
    ItemEntity.DISCOUNT_RATING.GREAT:
      %Sticker.texture = preload ("res://assets/sprites/stickers/sticker_great_deal.png")
    ItemEntity.DISCOUNT_RATING.GOOD:
      %Sticker.texture = preload ("res://assets/sprites/stickers/sticker_goo_deal.png")
    ItemEntity.DISCOUNT_RATING.FULL_PRICE, _:
      %Sticker.texture = preload ("res://assets/sprites/stickers/sticker_full_price.png")
