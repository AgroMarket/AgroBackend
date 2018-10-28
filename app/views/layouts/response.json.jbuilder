# json.array! @categories, partial: 'categories/category', as: :category

# json.user current_user
json.status @status
json.message @message
json.result @result, partial: @view, as: :category
json.error @error ||= nil