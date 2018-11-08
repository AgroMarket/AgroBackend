class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :user, optional: true
end
