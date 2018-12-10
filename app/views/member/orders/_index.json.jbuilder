json.orders_count @orders_count
json.orders do
	json.array! @orders do |order|
		json.order do
			json.id order.id
			json.date order.created_at
      json.producer order.producer.name
			json.status order.status
			json.link member_order_path (order.id)
			json.total order.total
		end
	end
end

json.pagination @pagination