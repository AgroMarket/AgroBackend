# json.extract! page, :id, :name, :title, :content, :created_at, :updated_at
# json.url page_url(page, format: :json)

json.api page_path page.id
json.id page.id
json.name page.name
json.title page.title
# json.content page.content
