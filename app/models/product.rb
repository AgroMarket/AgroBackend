class Product < ApplicationRecord
  belongs_to :category
  belongs_to :farmer
  has_and_belongs_to_many :carts

  validates :name, presence: :true
end
