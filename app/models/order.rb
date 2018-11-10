class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :farmer, optional: true

  belongs_to :consumer
  belongs_to :producer
  has_many :items
end
