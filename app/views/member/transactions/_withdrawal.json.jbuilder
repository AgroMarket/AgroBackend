json.transaction do
  json.account current_user.email
  json.after @after
  json.amount @amount
  json.ask_id ''
  json.before current_user.amount
  json.direction ''
  json.from current_user.email
  json.id ''
  json.link ''
  json.order_id ''
  json.task_id ''
  json.to current_user.email
  json.type 'withdrawal'
  json.need_money @need_money

end