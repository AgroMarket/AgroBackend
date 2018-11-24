class Order < ApplicationRecord
  belongs_to :consumer
  belongs_to :producer
  has_many :order_items, dependent: :destroy

  enum status: %i[Ожидает Выполнен Отклонен]

  def self.create_orders_from_cart(cart_id, user)
    cart = Cart.find(cart_id)
    cart.cart_items.map(&:product).map(&:producer).uniq.each do |producer|
      order_hash = {
        consumer: cart.consumer ? cart.consumer : user,
        producer: producer,
        status: 1
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
    true
  end

  def self.create_order_from_order(order_id)
    old_order = Order.find(order_id)
    new_order = old_order.dup
    new_order.status = 0
    new_order.save

    old_order.order_items.each do |item|
      old_item = item
      new_item = old_item.dup
      new_item.order = new_order
      new_item.save
    end
    new_order
  end
end
