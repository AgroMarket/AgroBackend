class Consumer < User
  has_many :orders
  has_many :producers, through: :orders
  has_many :transactions
  has_many :producers, through: :transactions
  has_one_attached :image
end
