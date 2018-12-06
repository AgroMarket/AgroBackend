# json.extract! member, :id, :amount, :user_type, :image, :name, :address, :phone, :description, :producer_logo, :producer_brand, :producer_address, :producer_phone, :producer_description, :producer_inn, :created_at, :updated_at
# json.url member_url(member, format: :json)

json.member do
  json.user_type member.user_type
  json.link member_path member.id
  json.amount member.amount
  json.id member.id

  json.name member.name
  json.email member.email
  json.address member.address
  json.phone member.phone
  json.descripion member.description
  json.image member.image.attached? ? url_for(member.image) : ''

  json.producer_brand member.producer_brand
  json.producer_address member.producer_address
  json.producer_phone member.producer_phone
  json.producer_descripion member.producer_description
  json.producer_inn member.producer_inn
  json.producer_logo member.logo.attached? ? url_for(member.logo) : ''
  json.sertificates do
    json.array! do
    end
  end
end