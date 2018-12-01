json.tranzactions do 
    json.array! @tranzactions do |tranzaction|
        json.tranzaction do
            json.id tranzaction.id
            json.user tranzaction.user
            json.to tranzaction.to
            json.sum    tranzaction.sum
            json.order  tranzaction.order
        end
    end
end