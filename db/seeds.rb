require 'category_names'

# frozen_string_literal: true

Consumer.destroy_all
Category.destroy_all

def missing_png
  { io: File.open("#{Rails.root}/app/assets/images/300x300/missing.png"), filename: 'missing.png' }
end

# Consumers
consumer = Array.new(5) do
  { email: FFaker::Internet.safe_email,
    password: '12341234',
    name: FFaker::NameRU.name,
    phone: FFaker::PhoneNumber.short_phone_number,
    address: FFaker::AddressRU.city,
    description: FFaker::HipsterIpsum.paragraph }
end
Consumer.create! consumer
User.all.each { |user| user.image.attach missing_png }

# Producer
9.times.each do |i|
  producer = { email: "farmer#{i}@mail.ru",
    password: '12341234',
    name: "farmer#{i}",
    phone: FFaker::PhoneNumber.short_phone_number,
    address: FFaker::AddressRU.city,
    description: FFaker::HipsterIpsum.paragraph,
    producer_logo: "",
    producer_brand: "Farmer#{i}",
    }
end

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


# Carts


# CartItems


# Orders


# OrderItems






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


