json.products do
  json.array! @products do |product|
    json.link product_path product.id
    json.image url_for(product.image)
    json.title product.name
    json.measures product.messures
    json.price product.price
    json.category_id product.category.id
    json.farmer_id product.farmer.id
    json.id product.id
    json.rank product.rank
  end
end

json.pagination @pagination