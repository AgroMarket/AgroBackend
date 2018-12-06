json.transaction do
  json.type   transaction.t_type
  json.id     transaction.id
  json.amount transaction.amount
  json.from   transaction.from.email
  json.to     transaction.to.email
  json.before transaction.before
  json.after  transaction.after
  json.ask    transaction.ask
  json.order  transaction.order
  # json.task   transaction.task
end