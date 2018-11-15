# json.extract! consumer, :id, :phome, :created_at, :updated_at
# json.url consumer_url(consumer, format: :json)

json.id consumer.id
json.name consumer.name
json.email consumer.email
json.phone consumer.phone
json.address consumer.address
json.image consumer.image ? url_for(consumer.image) : nil