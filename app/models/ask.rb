class Ask < ApplicationRecord
  belongs_to :consumer, class_name: 'Member', foreign_key: 'consumer_id'
  has_many :orders, dependent: :destroy
  has_many :tranzactions
  has_many :tasks

  enum status: %i[Ожидает Доставлен Выполнен]

  scope :by_consumer, ->(consumer) { where(consumer: consumer).includes(:orders).order('created_at DESC') }
end
