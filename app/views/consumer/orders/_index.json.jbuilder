# json.array! @orders, partial: 'orders/order', as: :order

json.array! @orders do |order|
	json.id order.id
	json.name "Список товаров"
	json.link consumer_order_path (order.id)
	json.date order.created_at
	json.total order.total
end