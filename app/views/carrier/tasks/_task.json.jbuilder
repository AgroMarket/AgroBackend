json.task do
  json.id task.id
  json.consumer_name task.member.name
  json.consumer_address task.member.address
  json.consumer_phone task.member.phone
  json.ask_sum  task.ask.sum
  json.delivery_cost task.delivery_cost
  json.ask_start task.ask.created_at
  json.task_start task.created_at
  json.task_end task.updated_at
  json.status task.status
  json.link carrier_task_path task.id
  json.ask task.ask
  json.ask task.ask, partial: 'member/asks/ask', as: :ask
end
