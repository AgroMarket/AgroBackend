json.producers do
  json.array! @producers do |producer|
    json.id producer.id
    json.name producer.name
    json.link producer_path producer.id
    json.logo url_for(producer.logo)
  end
end

json.pagination @pagination
