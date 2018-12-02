class Ask < ApplicationRecord
  belongs_to :consumer
  has_many :orders
  has_many :tranzactions
  has_many :tasks

  enum status: %i[Ожидает Доставлен Выполнен]
end
