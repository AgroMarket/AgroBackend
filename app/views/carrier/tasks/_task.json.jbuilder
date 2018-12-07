json.task do
  json.id task.id
  json.carrier_id task.carrier_id
  json.ask_id task.ask_id
  json.delivery_cost task.delivery_cost
  json.consumer_id task.member_id
  json.status task.status
end
