class Ask < ApplicationRecord
  belongs_to :consumer
  has_many :orders
end
