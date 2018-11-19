json.producers do
  json.array! @producers do |producer|
  	json.producer do
	    json.id producer.id
	    json.name producer.name
	    json.logo url_for(producer.logo)
	    json.link producer_path producer.id
  	end
  end
end

json.pagination @pagination
