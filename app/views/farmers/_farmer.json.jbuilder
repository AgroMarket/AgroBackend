# json.extract! farmer, :id, :created_at, :updated_at
# json.url farmer_url(farmer, format: :json)

json.link farmer_path farmer.id
json.id farmer.id
json.name farmer.user.name
json.image nil
json.descripion farmer.description
json.address farmer.address
json.inn farmer.inn
json.sertificates do
  json.array! do
  end
end