# json.extract! cart, :id, :created_at, :updated_at
# json.url cart_url(cart, format: :json)

json.cart_id cart.id
json.user_id cart.consumer.present? ? cart.consumer.id : nil
json.products do
  json.array! cart.cart_items do |item|
    json.tooltip "Поле cart_item_id это айдишник записи о товаре в корзине"
    json.cart_item_id item.id
    json.product_name item.product.name
    json.product_price item.product.price
    json.product_quantity item.quantity
    json.product_sum item.sum
    json.product_id item.product.id
    json.product_link product_path item.product.id
  end
end
json.total Cart.total cart.id