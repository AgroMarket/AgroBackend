# json.array! @categories, partial: 'categories/category', as: :category

json.user current_user
json.status 'status'
json.message 'message'
json.result do
  json.array! @categories do |category|
    json.id category.id
    json.name category.name
    json.parent_id category.parent_id
    json.rank category.rank
    json.children do
      json.array! category.children do |child|
        json.id child.id
        json.name child.name
        json.parent_id child.parent_id
        json.rank child.rank
      end
    end
  end
end
json.error 'null'
