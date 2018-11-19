json.consumer do
  json.id consumer.id
  json.name consumer.name
  json.email consumer.email
  json.phone consumer.phone
  json.address consumer.address
  json.image consumer.image ? url_for(consumer.image) : nil
  json.link consumer_path consumer.id
end