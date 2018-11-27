class Transaction < ApplicationRecord
  belongs_to :consumer
  belongs_to :producer
end
