class Category < ApplicationRecord
  has_many :products

  validate :name, presence: :true
end
