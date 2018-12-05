json.extract! member, :id, :amount, :type, :image, :name, :address, :phone, :description, :producer_logo, :producer_brand, :producer_address, :producer_phone, :producer_description, :producer_inn, :created_at, :updated_at
json.url member_url(member, format: :json)
