# json.extract! cart, :id, :created_at, :updated_at
# json.url cart_url(cart, format: :json)

json.id cart.id
json.user_id cart.user.present? ? cart.user.id : nil
json.products do
    json.array! cart.items do |item|
      json.cart_item_id item.id
      json.product_name item.product.name
      json.product_price item.product.price
      json.product_quantity item.quantity
      json.product_id item.product.id
      json.product_link product_path item.product.id
    end
end
