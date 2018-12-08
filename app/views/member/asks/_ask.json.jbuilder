json.ask do
  json.id ask.id
  json.date ask.created_at
  json.sum ask.sum
  json.delivery_cost ask.delivery_cost
  json.total ask.total
  json.status ask.status
  # json.link member_ask_path @ask.id
  json.orders do
    json.array! ask.orders do |order|
      json.partial! 'member/orders/order', order: order
    end
  end
end
json.transactions do
  json.array! @transactions do |transaction|
    json.partial! 'member/transactions/transaction', transaction: transaction
  end
end