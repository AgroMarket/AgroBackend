class Product < ApplicationRecord
  belongs_to :category
  belongs_to :farmer
  has_many :cart_products
  has_many :carts, through: :cart_products

  validates :name, presence: :true

  scope :samples, -> { find(pluck(:id).sample(8)) }
  scope :search, ->(string) { where("LOWER(name) LIKE ?", "%#{string}%") }
  scope :category, ->(category_id) { where(category_id: category_id) }
end
