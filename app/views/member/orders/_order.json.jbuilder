json.order do
  json.id order.id
  json.consumer_id order.consumer_id
  json.consumer_name order.consumer.name
  json.consumer_address order.consumer.address
  json.consumer_phone order.consumer.phone
  json.producer_id order.producer_id
  json.producer_name order.producer.name
  json.producer_address order.producer.address
  json.producer_phone order.producer.phone
  json.producer_link producer_path order.producer_id
  # json.name "Список товаров"
  # json.link consumer_ask_order_path (order.id)
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
      json.quantity item.quantity
      json.sum item.sum
      json.product_image url_for(item.product.image)
    end
  end
end