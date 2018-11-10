class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  has_many :items

  # добавляет один продукт
  def add_product product
    self.products.push(product) if product.is_a? Product
  end
end
