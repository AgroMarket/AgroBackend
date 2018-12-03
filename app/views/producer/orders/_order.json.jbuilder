json.order do
  json.id order.id
  json.producer_id order.producer_id
  json.producer_name order.producer.name
  json.producer_link producer_path order.producer_id
  json.name "Список товаров"
  json.link producer_order_path (order.id)
  json.date order.created_at
  json.status order.status
  json.total order.total
  json.order_items do
    json.array! order.order_items do |item|
      json.order_item_id item.id
      json.product_id item.product_id
      json.product_link product_path item.product_id
      json.product_name item.product.name
      json.product_price item.product.price
      json.product_quantity item.quantity
      json.product_sum item.sum
      json.product_image url_for(item.product.image)
    end

  end
end