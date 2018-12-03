json.dashboard do
  json.producers_count @dashboard[:producers_count]
  json.consumers_count @dashboard[:consumers_count]
  json.products_count @dashboard[:products_count]
  json.sales_count @dashboard[:orders_count]
  json.turnover @dashboard[:turnover]
  json.profit @dashboard[:profit]
end