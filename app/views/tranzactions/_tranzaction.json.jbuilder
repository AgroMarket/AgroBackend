#json.extract! tranzaction, :id, :users_id, :sum, :to, :orders_id, :status, :created_at, :updated_at
#json.url tranzaction_url(tranzaction, format: :json)

json.tranzaction do
    json.tranzaction_id tranzaction.id
    json.user tranzaction.user_id
    json.sum tranzaction.sum
    json.to tranzaction.to
    json.order_link tranzaction.order_id
    json.status tranzaction.status
end