
json.transactions_count current_user.transaction.size
json.transactions do
  json.array! @transactions, partial: 'member/transactions/transaction', as: :transaction
end
json.pagination @pagination