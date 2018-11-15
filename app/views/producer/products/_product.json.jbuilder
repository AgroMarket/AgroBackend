# json.extract! product, :id, :name, :messures, :price, :category_id, :created_at, :updated_at
# json.url product_url(product, format: :json)
json.product do
	json.id product.id
	json.link product_path product.id
	json.title product.name
	json.measures product.measures
	json.price product.price
	json.rank product.rank
	json.category_id product.category_id
	json.category_api category_products_path product.category_id
	json.producer_id product.producer.id
	json.producer_name product.producer.name
	json.producer_link producer_path product.producer.id
	json.producer_products producer_products_path product.producer.id
	json.descripion product.description
	json.image product.image.attached? ? url_for(product.image) : nil
end
