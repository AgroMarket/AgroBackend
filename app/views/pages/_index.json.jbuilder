json.pages do
  json.array! @pages, partial: 'pages/page', as: :page
end
