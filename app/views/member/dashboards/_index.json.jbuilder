json.dashboard do
  json.products_count @dashboard[:products_count]
  json.consumers_count @dashboard[:consumers_count]
  json.orders_count @dashboard[:orders_count]
  json.turnover @dashboard[:turnover]
  json.amount @dashboard[:amount]
end