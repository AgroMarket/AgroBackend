class Producer < Consumer
  has_many :products
  has_many :orders
  has_one_attached :logo
end
