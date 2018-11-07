# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :farmer
  has_many :cart_products
  has_many :carts, through: :cart_products
  # paperclip
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, presence: true
  do_not_validate_attachment_file_type :image

  validates :name, presence: :true

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
