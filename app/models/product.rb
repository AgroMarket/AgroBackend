# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :farmer
  has_many :cart_products
  has_many :carts, through: :cart_products
  has_one_attached :image
=begin
  # paperclip
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, presence: true
  do_not_validate_attachment_file_type :image
=end
  validates :name, presence: :true

  scope :samples, -> { find(pluck(:id).sample(8)) }
  scope :search, ->(string) { where('LOWER(name) LIKE ?', "%#{string.downcase!}%") }
  scope :category, ->(category_id) { where(category_id: category_id) }
  scope :parent_categories, ->(category_id) do
    if Category.find(category_id).parent_id.zero?
      Product.category Category.includes(:children).find(category_id).children
    else
      Product.category category_id
    end
  end
end
