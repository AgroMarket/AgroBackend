class Order < ApplicationRecord
  belongs_to :consumer
  belongs_to :producer
  has_many :order_items, dependent: :destroy

  enum status: %i[pending complеted rejected]

  def self.create_orders_from_cart(cart_id)
  	cart = Cart.find(cart_id)
    cart.cart_items.map(&:product).map(&:producer).uniq.each do |producer|
      order_hash = {
        consumer: cart.consumer,
        producer: producer,
        total: cart.total,
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
        end
      end
    end
    
    # cart.destroy if order.present?
    true
  end
end
