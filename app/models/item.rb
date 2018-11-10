class Item < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :user, optional: true
end
