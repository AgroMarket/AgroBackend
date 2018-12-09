require 'category_names'
require 'page_contents'
require 'ffaker'

# frozen_string_literal: true

Page.destroy_all
Administrator.destroy_all
Carrier.destroy_all
Member.destroy_all
Category.destroy_all
Product.destroy_all
Cart.destroy_all
Ask.destroy_all
Order.destroy_all
Task.destroy_all
Transaction.destroy_all

def missing_png
  { io: File.open("#{Rails.root}/app/assets/images/300x300/missing.png"), filename: 'missing.png' }
end

def picture_for_products(picture_name)
  { io: File.open("#{Rails.root}/app/assets/images/products/#{picture_name}.png"), filename: "#{picture_name}.png" }
end

Page.create! name: 'about',     title: 'О нас',             content: PageContents::ABOUT
Page.create! name: 'sellers',   title: 'Продавцам',         content: PageContents::SELLERS
Page.create! name: 'buyers',    title: 'Покупателям',       content: PageContents::BUYERS
Page.create! name: 'delivery',  title: 'Доставка и оплата', content: PageContents::DELIVERY

# Создаём пользователей: админа, профит и транспортная компания
first_user = Administrator.create! email: 'fermastore@mail.ru', password: '12341234', user_type: 'admin'
money_user = Administrator.create! email: 'profit@mail.ru', password: '12341234', user_type: 'admin'
carier = Carrier.create! email: 'carrier@mail.ru', password: '12341234', user_type: 'delivery'

first_user.image.attach ({ io: File.open("#{Rails.root}/app/assets/images/avatars/admin.jpg"), filename: "admin.jpg" })
carier.image.attach ({ io: File.open("#{Rails.root}/app/assets/images/avatars/tk.jpg"), filename: "tk.jpg" })
# first_user.add_role :admin
# transport_company.add_role :delivery
# money_user.add_role :money

# Consumers
(1..5).each do |i|
  consumer = { user_type: 'consumer',
               email: "consumer#{i}@mail.ru",
               password: '12341234',
               name: FFaker::NameRU.name,
               phone: FFaker::PhoneNumber.short_phone_number,
               address: FFaker::AddressRU.city,
               description: FFaker::HipsterIpsum.paragraph }
  Member.create! consumer
end
Member.all.each do |consumer|
 consumer.image.attach ({ io: File.open("#{Rails.root}/app/assets/images/avatars/#{rand(1..3)}.jpg"), filename: "avatar.jpg" })
end

# Producer
categories_count = CategoryNames::ALL.size
(1..categories_count).each do |i|
  name = FFaker::NameRU.name
  producer = { user_type: 'producer',
               email: "farmer#{i}@mail.ru",
               password: '12341234',
               name: name,
               phone: FFaker::PhoneNumber.short_phone_number,
               address: FFaker::AddressRU.city,
               description: FFaker::HipsterIpsum.paragraph,
               producer_logo: '',
               producer_brand: 'ИП' + name,
               producer_address: FFaker::AddressRU.city,
               producer_phone: FFaker::PhoneNumber.short_phone_number,
               producer_description: FFaker::HipsterIpsum.paragraph,
               producer_inn: rand(100000000..999999999).to_s }
  Member.create! producer
end
Member.all.each do |producer|
  producer.image.attach ({ io: File.open("#{Rails.root}/app/assets/images/avatars/#{rand(1..3)}.jpg"), filename: 'avatar.jpg' })
end
Member.all.each { |producer| producer.logo.attach missing_png }

# Categories
category_names = CategoryNames::ALL
category_names.each_with_index do |category_name, idx|
  category = Category.create! name: category_name[:name], icontype: category_name[:icontype], parent_id: 0, rank: idx + 1
  category_name[:children].each_with_index do |sub_name, sub_idx|
    category.children << Category.create!(name: sub_name[:name], parent_id: category.id, rank: sub_idx + 1)
  end
end
Category.where(parent_id: 0).each do |category|
  category.icon.attach(io: File.open("#{Rails.root}/app/assets/images/icons/#{category.icontype}.png"), filename: "#{category.icontype}.png")
end

# Products
Category.where(parent_id: 0).each_with_index do |parent, idx|
  parent.children.each do |category|
    12.times.each do |i|
      product = {
        name: "#{category.name} №#{i + 1}",
        description: FFaker::HipsterIpsum.paragraph,
        measures: 'кг',
        price: rand(100..1000),
        rank: i + 1,
        producer: Member.find_by(email: "farmer#{idx+1}@mail.ru"),
        category: category
      }
      Product.create! product
    end
  end
end
Product.all.each { |product| product.image.attach picture_for_products(product.category.parent.name) }

# Carts
cart = Cart.create! consumer: Member.consumers.first

# CartItems
Member.producers.first(4).each do |producer|
  producer.products.first(3).each do |product|
    quantity = 2
    cart_item = {
      cart: cart,
      product: product,
      producer: producer,
      quantity: quantity,
      sum: product.price * quantity
    }
    cart.cart_items << CartItem.create!(cart_item)
  end
end

puts 'cart start'
cart.cart_items.each do |item|
  cart_id = item.cart.id
  farmer_id = item.product.producer.id
  farmer = item.product.producer.name
  product_id = item.product.id
  product = item.product.name
  puts "  cart_id #{cart_id} farmer_id #{farmer_id} farmer_name #{farmer} product_id #{product_id} product_name #{product}"
end
puts 'cart end'
puts ''
p cart.total
puts ''


# Формирование заказа должно сопровождаться транзакциями:
#   зачисление на счет покупателя
#   списание со счета покупателя на счет системы

%w[consumer producer].each do |user_type|
  consumer = Member.where(user_type: user_type).first
  Transaction.transaction_replenish consumer, cart.total
  puts "consumer inflows #{consumer.inflows.size}"

  # Asks
  hash = {
    consumer: consumer,
    sum: cart.sum,
    delivery_cost: cart.delivery_cost,
    total: cart.total,
    status: 0
  }
  ask = Ask.create! hash

  # Orders
  cart.cart_items.map(&:product).map(&:producer).uniq.each do |producer|
    # для каждого производителя находим в корзине его товары и формируем из них заказ
    # puts "farmer_id #{producer.id}, farmer_name #{producer.name}"

    # создаем заказ
    order_hash = {
      ask: ask,
      consumer: cart.consumer,
      producer: producer,
      status: 0
    }
    order = Order.create!(order_hash)

    # если заказ создан, то наполняем его товарами
    if order.present?
      # выбираем из корзины записи относящиеся только к данному производителю
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
        order_id = order_item.order.id
        farmer_id = order_item.producer.id
        farmer_name = order_item.producer.name
        product_id = order_item.product.id
        product_name = order_item.product.name
        price = order_item.price
        quantity = order_item.quantity
        sum = order_item.sum
        # puts "  order_id #{order_id} farmer_id #{farmer_id} farmer_name #{farmer_name} product_id #{product_id} product_name #{product_name} price #{price} quantity #{quantity} sum #{sum}"

        order.order_items << order_item
        order.total += order_item.sum
        order.save
        # puts "    total #{order.total}"
      end

    end
  end
  # puts '', "Ask total: #{ask.total}"

  # cart.cart_items.destroy_all
  Transaction.transaction_reserve consumer, ask
end

# Подготовка к доставке и доставка должны сопровождаться изменениями статусов и транзакциями:
#   продавец подтверждает заказ
#   перевозчик подтвержает доствку
#   система зачисляет деньги

# Все продавцы подтверждают свои заказы.
# Заказы готовы к доставке
Order.all.each do |order|
  order.update! status: 1 # Доставляется
end

# # Перевозчик доставляет заказ покупателю
carier.tasks.each do |task|
  task.update! status: 1 # Доставлен
end
