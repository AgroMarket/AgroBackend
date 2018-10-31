json.array! @categories do |category|
  json.api category_products_path category.id
  json.id category.id
  json.name category.name
  json.parent_id category.parent_id
  json.rank category.rank
  json.children do
    json.array! category.children do |child|
      json.api category_products_path child.id
      json.id child.id
      json.name child.name
      json.parent_id child.parent_id
      json.rank child.rank
    end
  end
end