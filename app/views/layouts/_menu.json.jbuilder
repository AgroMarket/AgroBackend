json.categories do
  json.array! @categories do |category|
    json.category do
      json.link category_products_path category.id
      json.id category.id
      json.name category.name
      json.parent_id category.parent_id
      json.rank category.rank
      json.icon url_for(category.icon)
      json.children do
        json.array! category.children do |child|
          json.category do
            json.link category_products_path child.id
            json.id child.id
            json.name child.name
            json.parent_id child.parent_id
            json.rank child.rank
          end
        end
      end
    end
  end
end