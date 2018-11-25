json.page do
  # json.link page_path @page.id
  json.link "/api/pages/#{@page.name}"
  # json.id @page.id
  json.name @page.name
  json.title @page.title
  json.content @page.content
end
