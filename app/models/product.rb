# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :producer, class_name: 'Member', foreign_key: 'producer_id'
  has_many :cart_items
  has_many :order_items
  has_one_attached :image

  scope :active, -> {where("deleted IS FALSE")}
  scope :inactive, -> {where("deleted IS TRUE")}

  # validates :name, presence: :true

  scope :by_category, ->(category_id) { where(category_id: category_id) }
  scope :by_parent_categories, ->(category_id) do
    if Category.find(category_id).parent_id.zero?
      Product.by_category Category.includes(:children).find(category_id).children
    else
      Product.by_category category_id
    end
  end
  scope :by_producer, ->(producer_id) { where producer_id: producer_id }
  scope :search, ->(string) { where('LOWER(name) LIKE ?', "%#{string.downcase}%") }
  scope :samples, -> { find(pluck(:id).sample(8)) }

  def self.missing_png
    { io: File.open("#{Rails.root}/app/assets/images/300x300/missing.png"), filename: 'missing.png' }
  end
end
