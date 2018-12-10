# json.message "На счёте недостаточно средств"
json.cart_total @cart.total
json.consumer_amount current_user.amount
json.need_money @cart.total - current_user.amount