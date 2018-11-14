class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :producer, optional: true

  before_create   :prepare_cart_item
  before_save     :calculate_sum
  after_create    :calculate_cart_total
  after_save      :calculate_cart_total
  after_destroy   :calculate_cart_total

  private

  def prepare_cart_item
    self.producer = product.producer
    calculate_sum
  end

  def calculate_sum
    self.sum = product.price * quantity
  end

  def calculate_cart_total
    cart.total = cart.cart_items.map(&:sum).inject { |total, sum| total + sum }
    cart.save
  end
end
