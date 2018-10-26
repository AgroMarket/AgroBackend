# json.array! @categories, partial: 'categories/category', as: :category

json.header true, partial: 'layouts/header', as: :header
json.menu true, partial: 'layouts/menu', as: :menu
json.body do
  json.search true, partial: 'products/search', as: :search
  json.products true, partial: 'products/index', as: :products
end
json.footer true, partial: 'layouts/footer', as: :footer
