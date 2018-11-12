# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :producer
  has_many :cart_items
  has_many :order_items
  has_one_attached :image

  # validates :name, presence: :true

  scope :by_category, ->(category_id) { where(category_id: category_id) }
  scope :by_parent_categories, ->(category_id) do
    if Category.find(category_id).parent_id.zero?
      Product.by_category Category.includes(:children).find(category_id).children
    else
      Product.by_category category_id
    end
  end
  scope :by_farmer, ->(farmer_id) { where farmer_id: farmer_id }
  scope :search, ->(string) { where('LOWER(name) LIKE ?', "%#{string.downcase}%") }
  scope :samples, -> { find(pluck(:id).sample(8)) }
end
