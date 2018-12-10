class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :producer, class_name: 'Member', foreign_key: 'producer_id', optional: true

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
    if !cart.cart_items.empty?
      cart.sum = cart.cart_items.map(&:sum).inject { |total, sum| total + sum }
      cart.total = cart.sum + cart.delivery_cost      
    else
      cart.sum = 0
      cart.total = 0
    end
    cart.save
  end
end
