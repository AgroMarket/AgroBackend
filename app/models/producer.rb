class Producer < Consumer
  has_many :products
  has_many :orders
end
