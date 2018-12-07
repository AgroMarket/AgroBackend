class Order < ApplicationRecord
  belongs_to :ask
  belongs_to :consumer, class_name: 'Member', foreign_key: 'consumer_id'
  belongs_to :producer, class_name: 'Member', foreign_key: 'producer_id'
  has_many :order_items, dependent: :destroy
  has_many :transactions

  enum status: %i[Подтверждается Подтверждён Доставлен Выполнен]

  after_update :create_task

  def self.create_orders_from_cart(cart_id, user)
    order = nil
    cart = Cart.find(cart_id)

    hash = {
      consumer: user,
      sum: cart.sum,
      delivery_cost: cart.delivery_cost,
      total: cart.total,
      status: 0
    }
    ask = Ask.create! hash

    cart.cart_items.map(&:product).map(&:producer).uniq.each do |producer|
      order_hash = {
        ask: ask,
        consumer: cart.consumer ? cart.consumer : user,
        producer: producer,
        status: 0
      }
      order = Order.create!(order_hash)

      if order.present?
        CartItem.where(cart: cart, producer: producer).each do |cart_item|
          order_item_hash = {
            order: order,
            product: cart_item.product,
            producer: producer,
            price: cart_item.product.price,
            quantity: cart_item.quantity,
            sum: cart_item.sum
          }

          order_item = OrderItem.create!(order_item_hash)
          order.order_items << order_item
          order.total += order_item.sum
          order.save
        end
      end
    end
    cart.cart_items.destroy_all if order.present?
    ask
  end

  def create_task
    puts 'creating task'
    return unless ask_confirmed?

    hash = {
      carrier: Carrier.first,
      ask: ask,
      delivery_cost: ask.delivery_cost,
      member: consumer,
      status: 0
    }
    Task.create! hash
  end

  def ask_confirmed?
    ask.orders.count == ask.orders.where(status: 1).count
  end

  # def self.create_order_from_order(order_id)
  #   old_order = Order.find(order_id)
  #   new_order = old_order.dup
  #   new_order.status = 0
  #   new_order.save
  #
  #   old_order.order_items.each do |item|
  #     old_item = item
  #     new_item = old_item.dup
  #     new_item.order = new_order
  #     new_item.save
  #   end
  #   new_order
  # end
end
