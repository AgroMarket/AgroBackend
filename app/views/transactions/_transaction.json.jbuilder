json.extract! transaction, :id, :from_id, :to_id, :amount, :ask_id, :order_id, :status, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
