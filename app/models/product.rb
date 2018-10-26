class Product < ApplicationRecord
  belongs_to :category
  belongs_to :farmer
  has_many :cart_products
  has_many :carts, through: :cart_products

  validates :name, presence: :true
end
