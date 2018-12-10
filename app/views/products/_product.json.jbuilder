json.product do
	json.id product.id
	json.link product_path product.id
	json.title product.name
	json.measures product.measures
	json.price product.price
	json.rank product.rank
	json.category_id product.category_id
	json.category_link category_products_path product.category_id
	json.producer_id product.producer.id
	json.producer_name product.producer.name
	json.producer_link producer_path product.producer.id
	# json.producer_products producer_products_path(product.producer.id) # возвращает не тот путь, что надо
	json.descripion product.description
	json.image url_for(product.image)
end
