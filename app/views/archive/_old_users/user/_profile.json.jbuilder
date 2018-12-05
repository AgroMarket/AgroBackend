json.profile do
    json.type @consumer.roles.first.name
    json.email @consumer.email
    json.amount @consumer.amount
    json.profit @profit.amount ? @profit.amount : 0
end