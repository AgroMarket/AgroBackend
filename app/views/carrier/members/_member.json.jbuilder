# json.extract! member, :id, :amount, :user_type, :image, :name, :address, :phone, :description, :producer_logo, :producer_brand, :producer_address, :producer_phone, :producer_description, :producer_inn, :created_at, :updated_at
# json.url member_url(member, format: :json)

json.member do
  json.user_type member.user_type
  json.link member_path member.id
  json.amount member.amount
  json.id member.id
  json.email member.email
end