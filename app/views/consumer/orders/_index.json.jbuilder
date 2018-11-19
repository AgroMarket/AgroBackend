json.orders do
	json.array! @orders do |order|
		json.order do
			json.id order.id
			json.date order.created_at
			json.status order.status
			json.link consumer_order_path (order.id)
			json.total order.total
		end
	end
end

json.pagination @pagination