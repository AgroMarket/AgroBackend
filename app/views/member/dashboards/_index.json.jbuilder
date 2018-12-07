json.dashboard do
  json.buys_count_desc 'количество покупок'
  json.buys_count @dashboard[:buys_count]
  json.buys_sum_desc 'сумма покупок'
  json.buys_sum @dashboard[:buys_sum]
  json.producers_count_desc 'количество поставщиков'
  json.producers_count @dashboard[:producers_count]
  json.products_count_desc 'количество товаров'
  json.products_count @dashboard[:products_count]
  json.sells_count_desc 'количество продаж'
  json.sells_count @dashboard[:sells_count]
  json.sells_sum_desc 'сумма продаж'
  json.sells_sum @dashboard[:sells_sum]
  json.consumers_count_desс 'количество покупателей'
  json.consumers_count @dashboard[:consumers_count]
  json.amount_desc 'количество денег на счету'
  json.amount @dashboard[:amount]
end