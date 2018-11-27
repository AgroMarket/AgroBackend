json.extract! transaction, :id, :consumer_id, :producer_id, :sum, :direction, :status, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
