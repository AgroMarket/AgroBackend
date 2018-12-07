json.transaction do
  json.account    transaction.account.email
  json.type       transaction.t_type
  json.direction  transaction.direction
  json.id         transaction.id
  json.amount     transaction.amount
  json.from       transaction.from.email
  json.to         transaction.to.email
  json.before     transaction.before
  json.after      transaction.after
  json.ask_id     transaction.ask_id
  json.order_id   transaction.order_id
  json.task_id    transaction.task_id
  json.link       member_transaction_path transaction.id
end