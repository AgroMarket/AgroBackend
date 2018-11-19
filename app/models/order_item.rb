class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :producer, optional: true
end
