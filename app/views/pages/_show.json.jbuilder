json.page do
  json.link page_path @page.id
  json.id @page.id
  json.name @page.name
  json.title @page.title
  json.content @page.content
end
