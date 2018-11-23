json.consumer do
  json.role consumer.type
	json.id consumer.id
	json.name consumer.name
	json.email consumer.email
	json.phone consumer.phone
	json.address consumer.address
	json.image consumer.image.attached? ? url_for(consumer.image) : nil
end