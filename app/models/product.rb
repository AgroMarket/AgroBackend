# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :farmer
  has_many :cart_products
  has_many :carts, through: :cart_products

  validates :name, presence: :true

  scope :samples, -> { find(pluck(:id).sample(8)) }
  scope :search, ->(string) { where('LOWER(name) LIKE ?', "%#{string}%") }
  scope :category, ->(category_id) { where(category_id: category_id) }
  scope :parent_categories, ->(category_id) do
    if Category.find(category_id).parent_id.zero?
      Product.category Category.includes(:children).find(category_id).children
    else
      Product.category category_id
    end
  end
end
