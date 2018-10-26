class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_products
  has_many :products, through: :cart_products

  # добавляет один продукт
  def add_product product
    self.products.push(product) if product.is_a? Product
  end
end
