# json.extract! cart, :id, :created_at, :updated_at
# json.url cart_url(cart, format: :json)

json.cart do
  json.id cart.id
  json.sum cart.sum
  json.delivery_cost cart.delivery_cost
  json.total cart.total
  json.consumer_id cart.consumer.present? ? cart.consumer.id : nil
  json.cart_items do
    json.array! cart.cart_items do |item|
      json.cart_item do
          json.id item.id
          json.product do
            json.id item.product.id
            json.name item.product.name
            json.price item.product.price
            json.producer item.product.producer.name
            json.producer_id item.product.producer_id
            json.link product_path item.product.id
            json.image url_for(item.product.image)
          end
          json.quantity item.quantity
          json.sum item.sum
      end
    end
  end
end
