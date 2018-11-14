class Order < ApplicationRecord
  belongs_to :consumer
  belongs_to :producer
  has_many :order_items, dependent: :destroy

  enum status: %i[pending complеted rejected]
end
