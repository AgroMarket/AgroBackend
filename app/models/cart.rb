class Cart < ApplicationRecord
  belongs_to :consumer, optional: true
  has_many :cart_items, dependent: :destroy

  def calculate_order_total
    self.total = cart_items.map(&:sum).inject { |total, sum| total + sum }
  end
end
