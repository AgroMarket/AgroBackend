json.extract! producer, :id, :logo, :brand, :producer_description, :producer_address, :producer_phone, :inn, :created_at, :updated_at
json.url producer_url(producer, format: :json)
