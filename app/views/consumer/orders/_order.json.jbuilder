# json.extract! order, :id, :created_at, :updated_at
# json.url order_url(order, format: :json)

json.id order.id
json.name "Список товаров"
json.link consumer_order_path (order_id)
json.date order.created_at
json.total order.total