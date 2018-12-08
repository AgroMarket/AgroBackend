json.task do
  json.id task.id
  json.carrier_id task.carrier_id
  json.delivery_cost task.delivery_cost
  json.consumer task.member.name
  json.status task.status
  json.created_at task.created_at
  json.link carrier_task_path task.id
  json.ask task.ask
end
