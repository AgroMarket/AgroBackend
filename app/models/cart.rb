class Cart < ApplicationRecord
  belongs_to :consumer, optional: true
  has_many :cart_items, dependent: :destroy

  # def calculate_cart_total
  #   self.total = cart_items.map(&:sum).inject { |total, sum| total + sum }
  #   save
  # end
end
