
json.inflows_count current_user.inflows.size
json.inflows do
  json.array! @transactions, partial: 'member/transactions/transaction', as: :transaction
end
json.pagination @pagination