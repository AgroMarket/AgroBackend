
json.payments_count current_user.payments.size
json.payments do
  json.array! @transactions, partial: 'member/transactions/transaction', as: :transaction
end
json.pagination @pagination