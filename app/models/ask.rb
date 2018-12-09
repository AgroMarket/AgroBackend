class Ask < ApplicationRecord
  belongs_to :consumer, class_name: 'Member', foreign_key: 'consumer_id'
  has_many :orders, dependent: :destroy
  has_many :tranzactions
  has_many :tasks

  # enum status: %i[Ожидает Доставлен Выполнен]
  enum status: %i[Упаковывается Доставляется Доставлен Отменён]

  after_update :make_system_payments

  scope :by_consumer, ->(consumer) { where(consumer: consumer).includes(:orders).order('created_at DESC') }
  scope :by_consumer_and_status, ->(consumer, status) { where(consumer: consumer, status: status).includes(:orders).order('created_at DESC') }

  def producers
    orders.map(&:producer)
  end

  def make_system_payments
    if status == "Доставлен"
      Transaction.system_payments self
      orders.each do |order|
        order.update! status: 2 # Доставлен
      end
    end
  end
end
