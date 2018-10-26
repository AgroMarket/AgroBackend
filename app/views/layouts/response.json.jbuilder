# json.array! @categories, partial: 'categories/category', as: :category

# json.user current_user
json.status @status
json.message @message
json.result @result, partial: 'categories/home', as: :category
# json.result do
#   json.header do
#     json.logo do
#       json.api ""
#       json.name "Ferma Store"
#       json.image ""
#     end
#     json.cart do
#       json.api ""
#       json.name "Корзина"
#       json.image ""
#     end
#     json.singin do
#       json.api ""
#       json.name "Вход"
#     end
#   end
#   json.menu do
#     json.array! @categories do |category|
#       json.api ""
#       json.id category.id
#       json.name category.name
#       json.parent_id category.parent_id
#       json.rank category.rank
#       json.children do
#         json.array! category.children do |child|
#           json.api ""
#           json.id child.id
#           json.name child.name
#           json.parent_id child.parent_id
#           json.rank child.rank
#         end
#       end
#     end
#   end
#   json.body do
#     json.search do
#       json.api ""
#     end
#     json.products do
#       json.array! @products do |product|
#         json.api ""
#         json.id product.id
#         json.name product.name
#         json.messures product.messures
#         json.image ""
#       end
#     end
#   end
# end
json.error @error ||= nil