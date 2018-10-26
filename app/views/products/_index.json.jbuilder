json.array! @products do |product|
  json.api ""
  json.id product.id
  json.name product.name
  json.messures product.messures
  json.image ""
end