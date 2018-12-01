class Transaction < ApplicationRecord
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'
  belongs_to :ask
  belongs_to :order

  enum status: %i[Пополнение Резерв Оплата]
end
