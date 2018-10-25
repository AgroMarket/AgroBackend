class Cart < ApplicationRecord
  has_and_belongs_to_many :product
  belongs_to :farmer
end
