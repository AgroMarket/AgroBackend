class Consumer < User
  has_many :orders
  has_many :producers, through: :orders
  has_one_attached :image
end
