class Order < ApplicationRecord
  belongs_to :ask
  belongs_to :consumer
  belongs_to :producer
  has_many :order_items, dependent: :destroy
  has_many :transactions

  enum status: %i[Подтверждается Подтверждён Доставлен Выполнен]

  def self.create_orders_from_cart(cart_id, user)
    order = nil
    cart = Cart.find(cart_id)
    # добавил к итоговой сумме заказа доставку, так же было consumer: Consumer.first
    ask = Ask.create! consumer: user, amount: cart.total + cart.delivery_cost, status: 0
    # Похоже, что проблема в этой функции здесь
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
