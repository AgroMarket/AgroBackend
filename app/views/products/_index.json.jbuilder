json.products do
  json.array! @products do |product|
    json.api product_path product.id
    json.id product.id
    json.name product.name
    json.messures product.messures
    json.image ""
    json.category_id product.category.id
  end
end

json.pagination ""#paginate(json: @products)