class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :producer, class_name: 'Member', foreign_key: 'producer_id', optional: true
end
