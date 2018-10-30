json.extract! page, :id, :name, :title, :content, :created_at, :updated_at
json.url page_url(page, format: :json)
