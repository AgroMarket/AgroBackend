json.asks_count @asks_count
json.asks do
  json.array! @asks do |ask|
    json.ask do
      json.id ask.id
      json.date ask.created_at
      json.sum ask.sum
      json.delivery_cost ask.delivery_cost
      json.total ask.total
      json.status ask.status
      json.link member_ask_path ask.id
    end
  end
end

json.pagination @pagination