json.tranzactions do |tranzaction|
    json.id tranzaction.id
    json.user tranzaction.user_id
    json.to tranzaction.to
    json.sum    tranzaction.sum
    json.order  tranzaction.order
end