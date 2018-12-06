class Member < User
  has_many :products, foreign_key: 'producer_id'
  has_many :orders, foreign_key: 'producer_id'
  has_many :consumers, through: :orders
  has_many :asks, foreign_key: 'consumer_id'
  has_many :buys, class_name: 'Order', foreign_key: 'consumer_id'
  has_many :producers, through: :buys
  has_one_attached :image
  has_one_attached :logo

  def buyers
    consumers.distinct
  end

  def sellers
    producers.distinct
  end

  def self.consumers
    Member.where(user_type: 'consumer')
  end

  def self.producers
    Member.where(user_type: 'producer')
  end

end
