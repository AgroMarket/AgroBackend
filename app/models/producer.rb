class Producer < Consumer
  has_many :products
  has_many :orders
  has_many :consumers, through: :orders
  has_many :transactions
  has_many :consumers, through: :transactions
  has_one_attached :logo
end
