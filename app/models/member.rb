class Member < User
  has_many :products, foreign_key: 'producer_id'
  has_one_attached :image
  has_one_attached :logo

  def self.consumers
    Member.where(user_type: 'consumer')
  end

  def self.producers
    Member.where(user_type: 'producer')
  end
end
