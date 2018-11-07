# json.extract! product, :id, :name, :messures, :price, :category_id, :created_at, :updated_at
# json.url product_url(product, format: :json)

json.link product_path product.id
json.image url_for(product.image)
json.title product.name
json.measures product.messures
json.price product.price
json.rank product.rank
json.category_id product.category_id
json.category_api category_products_path product.category_id
json.farmer_id product.farmer_id
json.farmer_name product.farmer.user.name
json.farmer_link farmer_path product.farmer_id
json.farmer_products farmer_products_path product.farmer_id
json.id product.id
json.descripion product.description
