p @consumers
json.consumers do
  json.array! @consumers, partial: 'members/member', as: :member
end

json.pagination @pagination