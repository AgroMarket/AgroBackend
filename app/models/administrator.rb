class Administrator < User
  has_one_attached :image
  def self.dashboard
    { producers_count: Member.producers.count,
      consumers_count: Member.consumers.count,
      products_count: Product.count,
      orders_count: Order.count,
      turnover: Ask.sum(:total),
      profit: Administrator.second.amount }
  end
end
