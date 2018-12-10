# json.array! @transactions do |transaction|
#     json.id transaction.id
#     json.from transaction.from
#     json.amount transaction.amount
#     json.to transaction.to
#     json.ask    transaction.ask
#     json.order  transaction.order
#     json.status transaction.status
# end

json.transaction do
  json.id @transaction.id
  json.from @transaction.from
  json.amount @transaction.amount
  json.to @transaction.to
  json.ask    @transaction.ask
  json.order  @transaction.order
  json.status @transaction.status
end