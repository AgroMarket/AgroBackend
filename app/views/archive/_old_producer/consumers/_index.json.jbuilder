p @consumers
json.consumers do
  json.array! @consumers, partial: 'producer/consumers/consumer', as: :consumer
end

json.pagination @pagination