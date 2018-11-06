# json.extract! product, :id, :name, :messures, :price, :category_id, :created_at, :updated_at
# json.url product_url(product, format: :json)

json.link product_path product.id
json.image product.image
json.title product.name
json.measures product.messures
json.price product.price
json.rank product.rank
json.category_id product.category_id
json.category_api category_products_path product.category_id
json.farmer_id product.farmer_id
json.farmer_api ""#farmer_path product.farmer_id
json.id product.id
json.descripion product.description
