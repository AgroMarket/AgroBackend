class Ask < ApplicationRecord
  belongs_to :consumer
  has_many :orders
  has_many :tranzactions
end
