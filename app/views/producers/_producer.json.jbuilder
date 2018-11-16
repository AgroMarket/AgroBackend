json.producer do
	json.link producer_path producer.id
	json.id producer.id
	json.name producer.name
	json.email producer.email
	json.address producer.producer_address
	json.phone producer.producer_phone
	json.inn producer.producer_inn
	json.descripion producer.producer_description
	json.logo url_for(producer.logo)
	json.sertificates do
	  json.array! do
	  end
	end
end