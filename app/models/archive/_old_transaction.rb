class Transaction < ApplicationRecord
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
  belongs_to :ask, optional: true
  belongs_to :order, optional: true

  enum status: %i[Пополнение Резерв Оплачен Вывод]
end
