# json.extract! producer, :id, :logo, :brand, :producer_description, :producer_address, :producer_phone, :inn, :created_at, :updated_at
# json.url producer_url(producer, format: :json)

json.link producer_path producer.id
json.id producer.id
json.name producer.name
json.email producer.email
json.logo url_for(producer.logo)
json.descripion producer.producer_description
json.address producer.producer_address
json.phone producer.producer_phone
json.inn producer.inn
json.sertificates do
  json.array! do
  end
end