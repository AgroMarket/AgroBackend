# json.extract! cart, :id, :created_at, :updated_at
# json.url cart_url(cart, format: :json)

json.cart_id cart.id
json.user_id cart.consumer.present? ? cart.consumer.id : nil
json.products do
  json.array! cart.cart_items do |item|
    json.product do
        json.cart_item_id item.id
        json.id item.product.id
        json.name item.product.name
        json.price item.product.price
        json.quantity item.quantity
        json.sum item.sum
        json.image url_for(item.product.image)
        json.link product_path item.product.id
    end
  end
end
json.total cart.total
json.delivery_cost cart.delivery_cost
