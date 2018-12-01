require 'category_names'
require 'page_contents'

# frozen_string_literal: true

Consumer.destroy_all
Producer.destroy_all
Category.destroy_all
Product.destroy_all
Cart.destroy_all
Order.destroy_all
Page.destroy_all

def missing_png
  { io: File.open("#{Rails.root}/app/assets/images/300x300/missing.png"), filename: 'missing.png' }
end

# Создаём первого пользователя ФермаСторе
first_user = User.create! ({email: 'FermaStore@mail.ru', password: '12341234', avatar: ''})
money_user = User.create! ({email: 'money@mail.ru', password: '12341234', avatar: ''})
transport_company = User.create! ({email: 'transport@mail.ru', password: '12341234', avatar: ''})

# Consumers
(1..5).each do |i|
  consumer = { email: "consumer#{i}@mail.ru",
               password: '12341234',
               name: FFaker::NameRU.name,
               avatar: '',
               phone: FFaker::PhoneNumber.short_phone_number,
               address: FFaker::AddressRU.city,
               description: FFaker::HipsterIpsum.paragraph }
  Consumer.create! consumer
end
# Consumer.all.each { |consumer| consumer.image.attach missing_png }

# Producer
(1..12).each do |i|
  producer = { email: "farmer#{i}@mail.ru",
               password: '12341234',
               name: "farmer#{i}",
               phone: FFaker::PhoneNumber.short_phone_number,
               address: FFaker::AddressRU.city,
               description: FFaker::HipsterIpsum.paragraph,
               producer_logo: '',
               producer_brand: "Farmer#{i}",
               producer_address: FFaker::AddressRU.city,
               producer_phone: FFaker::PhoneNumber.short_phone_number,
               producer_description: FFaker::HipsterIpsum.paragraph,
               producer_inn: rand(100000000..999999999).to_s }
  Producer.create! producer
end
Producer.all.each { |producer| producer.logo.attach missing_png }

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
        producer: Producer.find_by(email: "farmer#{idx+1}@mail.ru"),
        category: category
      }
      Product.create! product
    end
  end
end
Product.all.each { |product| product.image.attach missing_png }

# Carts
cart = Cart.create! consumer: Consumer.first

# CartItems
Producer.first(4).each do |producer|
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

# Asks
ask = Ask.create! consumer: Consumer.first, amount: cart.total + cart.delivery_cost, status: 0

# Orders
cart.cart_items.map(&:product).map(&:producer).uniq.each do |producer|
  # для каждого производителя находим в корзине его товары и формируем из них заказ
  puts "farmer_id #{producer.id}, farmer_name #{producer.name}"

  # создаем заказ
  order_hash = {
    ask: ask,
    consumer: cart.consumer,
    producer: producer,
    status: 1
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
      puts "  order_id #{order_id} farmer_id #{farmer_id} farmer_name #{farmer_name} product_id #{product_id} product_name #{product_name} price #{price} quantity #{quantity} sum #{sum}"

      order.order_items << order_item
      order.total += order_item.sum
      order.save
      puts "    total #{order.total}"
    end

  end
end
puts '', "Ask total: #{ask.amount}"

cart.cart_items.destroy_all


# создаём транзакции
boss_user = User.find_by(email: 'fermastore@mail.ru')
Consumer.all.each do |user|
  asks = user.asks
  if asks.orders 
    asks.each do |ask|
      ask.orders.each do |order|
        tranzactions_first = {
          from: order.consumer,
          amount: order.total,
          to: order.producer,
          status: 2,
          order: order,
          ask: ask
        }
        order.producer.amount += order.total
        puts order.producer.amount
        Transaction.create! tranzactions_first
      end
    end
  end
end

boss_user.save

# Переводим транзакции в статус

# Pages
# Page.create! name: 'main',      title: 'Ferma Store',       content: ''
Page.create! name: 'about',     title: 'О нас',             content: PageContents::ABOUT
Page.create! name: 'sellers',   title: 'Продавцам',         content: PageContents::SELLERS
Page.create! name: 'buyers',    title: 'Покупателям',       content: PageContents::BUYERS
Page.create! name: 'delivery',  title: 'Доставка и оплата', content: PageContents::DELIVERY
# Page.create! name: 'basket',    title: 'Корзина',           content: ''

# def missing_png
#   {
#     io: File.open("#{Rails.root}/app/assets/images/300x300/missing.png"),
#     filename: 'missing.png'
#   }
# end
#
# User.destroy_all
# Category.destroy_all
# Product.destroy_all
# Page.destroy_all
# Cart.destroy_all
#
#
# def random_inn
#   rand(100000000..999999999).to_s
# end
#
# users = 5.times.map do
#   {
#     email: FFaker::Internet.safe_email,
#     name: FFaker::NameRU.name,
#     password: 'password',
#     telephone: FFaker::PhoneNumber.short_phone_number,
#     address: FFaker::AddressRU.city,
#     description: FFaker::HipsterIpsum.paragraph
#   }
# end
# User.create! users
#
# # User.all.each { |user| user.image.attach missing_png }
#
# u = User.first
# u.roles = Role.all
#
# farmers = User.last(2)
# farmers.each do |s|
#   s.add_role :farmer
#   s.farmer = Farmer.create(inn: random_inn, description: FFaker::HipsterIpsum.paragraph, address: FFaker::AddressRU.city)
# end
#
# # Categories
# category_names = [
#     {name: 'Мёд', icontype: 'мед', children: [
#         {name: 'Мёд'},
#         {name: 'Мёд в сотах'},
#         {name: 'Продукты пчеловодства'}
#     ]},
#     {name: 'Овощи фрукты', icontype: 'овощи', children: [
#         {name: 'Зелень'},
#         {name: 'Овощи'},
#         {name: 'Фрукты'}
#     ]},
#     {name: 'Орехи', icontype: 'орех', children: [
#         {name: 'Орехи'},
#         {name: 'Семечки'},
#         {name: 'Орехи, семечки очищенные'}
#     ]},
#     {name: 'Молочные продукты', icontype: 'молоко',  children: [
#         {name: 'Молоко, сливки'},
#         {name: 'Кефир, ряженка'},
#         {name: 'Сметана'},
#         {name: 'Сыр'},
#         {name: 'Творог'}
#     ]},
#     {name: 'Крупы, Бобовые', icontype: 'крупа', children: [
#         {name: 'Гречка'},
#         {name: 'Пшеница'},
#         {name: 'Пшено'},
#         {name: 'Горох'},
#         {name: 'Фасоль'},
#         {name: 'Соя'},
#         {name: 'Чечевица'}
#     ]},
#     {name: 'Готовые продукты, заготовки', icontype: 'заготовка', children: [
#         {name: 'Хлебобулочные изделия'},
#         {name: 'Консервированные продукты'},
#         {name: 'Мясные деликатесы'},
#         {name: 'Пельмени, вареники'},
#         {name: 'Соусы, специи'},
#         {name: 'Кондитерские изделия'}
#     ]},
#     {name: 'Птица, Яйцо', icontype: 'птица', children: [
#         {name: 'Курица'},
#         {name: 'Индейка'},
#         {name: 'Гусь'},
#         {name: 'Утка'},
#         {name: 'Яйцо'}
#     ]},
#     {name: 'Рыба, Морепродукты', icontype: 'рыба', children: [
#         {name: 'Замороженная рыба'},
#         {name: 'Копченная, соленая, вяленная рыба'},
#         {name: 'Свежая рыба'},
#         {name: 'Икра'}
#     ]},
#     {name: 'Грибы, Ягоды', icontype: 'гриб', children: [
#         {name: 'Свежие ягоды'},
#         {name: 'Замороженные ягоды'},
#         {name: 'Сущеные ягоды'},
#         {name: 'Свежие грибы'},
#         {name: 'Замороженные грибы'},
#         {name: 'Соленые грибы'},
#         {name: 'Сушенные грибы'}
#     ]},
#     {name: 'Напитки', icontype: 'напиток', children: [
#         {name: 'Соки'},
#         {name: 'Морс'},
#         {name: 'Квас'},
#         {name: 'Сиропы'},
#         {name: 'Чай'}
#     ]},
#     {name: 'Масла, Жиры', icontype: 'масло', children: [
#         {name: 'Масло сливочное'},
#         {name: 'Масло растительное'},
#         {name: 'Жир животный'}
#     ]},
#     {name: 'Мясо', icontype: 'мясо', children: [
#         {name: 'Говядина'},
#         {name: 'Свинина'},
#         {name: 'Баранина'},
#         {name: 'Крольчатина'},
#         {name: 'Субпродукты'}
#     ]},
# ]
# category_names.each_with_index do |category_name, idx|
#   category = Category.create! name: category_name[:name], icontype: category_name[:icontype], parent_id: 0, rank: idx + 1
#   category_name[:children].each_with_index do |sub_name, sub_idx|
#     category.children << Category.create!(name: sub_name[:name], parent_id: category.id, rank: sub_idx + 1)
#   end
# end
#
# Category.where(parent_id: 0).each do |category|
#   category.icon.attach(io: File.open("#{Rails.root}/app/assets/images/icons/#{category.icontype}.png"), filename: "#{category.icontype}.png")
# end
#
#
# farmers = Farmer.all
#
# # Products
# Category.where(parent_id: 0).each do |parent|
#   parent.children.each do |category|
#     6.times.each do |idx|
#       product = {
#           name: "#{category.name} №#{idx + 1}",
#           description: FFaker::HipsterIpsum.paragraph,
#           category: category,
#           messures: "кг",
#           rank: idx + 1,
#           price: rand(1..10),
#           farmer: farmers.sample
#       }
#       Product.create! product
#     end
#   end
# end
#
# products = Product.all
# products.each do |pr|
#   pr.image.attach missing_png
# end
#
# # cart
# users = User.all
# cart_hash = []
# users.each do |user|
#   cart_hash << {
#       user: user,
#       products: 10.times.map do
#         Product.all.sample
#        end
#       }
# end
#
# Cart.create! cart_hash
#
# # orders
#
# 10.times.map do
#   user = User.all.sample
#   farmer = Farmer.all.sample
#   order_hash = {
#       user: user,
#       farmer: farmer,
#       quantity: user.cart.products.count,
#       total_price: user.cart.products.sum(:price)
#   }
#   Order.create order_hash
# end
#
#
# # Pages
# Page.create! name: 'main',      title: 'Ferma Store',       content: 'Текст'
# Page.create! name: 'about',     title: 'О нас',             content: 'Текст'
# Page.create! name: 'sellers',   title: 'Продавцам',         content: 'Текст'
# Page.create! name: 'buyers',    title: 'Покупателям',       content: 'Текст'
# Page.create! name: 'delivery',  title: 'Доставка и оплата', content: 'Текст'
# Page.create! name: 'basket',    title: 'Корзина',           content: 'Текст'


