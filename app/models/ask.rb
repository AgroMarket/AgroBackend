class Ask < ApplicationRecord
  belongs_to :consumer, class_name: 'Member', foreign_key: 'consumer_id'
  has_many :orders, dependent: :destroy
  has_many :tranzactions
  has_many :tasks

  # enum status: %i[Ожидает Доставлен Выполнен]
  enum status: %i[Упаковывается Доставляется Доставлен]

  after_update :make_system_payments

  scope :by_consumer, ->(consumer) { where(consumer: consumer).includes(:orders).order('created_at DESC') }

  def producers
    orders.map(&:producer)
  end

  def make_system_payments
    Transaction.system_payments self if status == 2
  end
end
