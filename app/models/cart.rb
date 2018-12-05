class Cart < ApplicationRecord
  belongs_to :consumer, class_name: 'Member', foreign_key: 'consumer_id', optional: true
  has_many :cart_items, dependent: :destroy

  before_create   :set_delivery_cost

  def set_delivery_cost
    self.delivery_cost = 500
  end
end
