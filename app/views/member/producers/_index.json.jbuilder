json.producers_count current_user.producers.distinct.size
json.producers do
  json.array! @producers do |producer|
  	json.producer do
	    json.id producer.id
	    json.name producer.name
      json.phone producer.phone
      json.address producer.address
			json.email producer.email
			json.producer_brand producer.producer_brand
			json.producer_address producer.producer_address
			json.producer_phone producer.producer_phone
			json.producer_inn producer.producer_inn
	    json.logo url_for(producer.logo)
			json.link producer_path producer.id
  	end
  end
end

json.pagination @pagination
