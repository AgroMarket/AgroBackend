json.extract! product, :id, :name, :messures, :price, :image, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
