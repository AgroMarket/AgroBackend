class Transaction < ApplicationRecord
  belongs_to :from, class_name: 'User', foreign_key: 'from_id'
  belongs_to :to, class_name: 'User', foreign_key: 'to_id'
  belongs_to :ask, optional: true
  belongs_to :order, optional: true
  # belongs_to :task, optional: true
end
