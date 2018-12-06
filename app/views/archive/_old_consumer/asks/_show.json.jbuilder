# json.partial! "asks/ask", ask: @ask

json.ask do
  json.id @ask.id
  json.date @ask.created_at
  json.sum @ask.sum
  json.delivery_cost @ask.delivery_cost
  json.total @ask.total
  json.status @ask.status
  json.link consumer_ask_path @ask.id
  json.orders do
    json.array! @ask.orders do |order|
      json.partial! "consumer/orders/order", order: order
    end
  end
end