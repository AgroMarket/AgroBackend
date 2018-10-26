class Order < ApplicationRecord
  belongs_to :user
  belongs_to :farmer
end
