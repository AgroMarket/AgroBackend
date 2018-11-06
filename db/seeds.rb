# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Category.destroy_all
Product.destroy_all
Page.destroy_all

def random_inn
  rand(100000000..999999999).to_s
end

users = 5.times.map do
  {
    email: FFaker::Internet.safe_email,
    name: FFaker::NameRU.name,
    password: 'password',
    telephone: FFaker::PhoneNumber.short_phone_number,
    address: FFaker::AddressRU.city,
    description: FFaker::HipsterIpsum.paragraph
  }
end
User.create! users

u = User.first
u.roles = Role.all

farmers = User.last(2)
farmers.each do |s|
  s.add_role :farmer
  s.farmer = Farmer.create(inn: random_inn, description: FFaker::HipsterIpsum.paragraph, address: FFaker::AddressRU.city)
end

# Categories
category_names = [
    {name: 'Мёд', children: [
        {name: 'Мёд'},
        {name: 'Мёд в сотах'},
        {name: 'Продукты пчеловодства'}
    ]},
    {name: 'Овощи фрукты', children: [
        {name: 'Зелень'},
        {name: 'Овощи'},
        {name: 'Фрукты'}
    ]},
    {name: 'Орехи', children: [
        {name: 'Орехи'},
        {name: 'Семечки'},
        {name: 'Орехи, семечки очищенные'}
    ]},
    {name: 'Молочные продукты', children: [
        {name: 'Молоко, сливки'},
        {name: 'Кефир, ряженка'},
        {name: 'Сметана'},
        {name: 'Сыр'},
        {name: 'Творог'}
    ]},
    {name: 'Крупы, Бобовые', children: [
        {name: 'Гречка'},
        {name: 'Пшеница'},
        {name: 'Пшено'},
        {name: 'Горох'},
        {name: 'Фасоль'},
        {name: 'Соя'},
        {name: 'Чечевица'}
    ]},
    {name: 'Готовые продукты, заготовки', children: [
        {name: 'Хлебобулочные изделия'},
        {name: 'Консервированные продукты'},
        {name: 'Мясные деликатесы'},
        {name: 'Пельмени, вареники'},
        {name: 'Соусы, специи'},
        {name: 'Кондитерские изделия'}
    ]},
    {name: 'Птица, Яйцо', children: [
        {name: 'Курица'},
        {name: 'Индейка'},
        {name: 'Гусь'},
        {name: 'Утка'},
        {name: 'Яйцо'}
    ]},
    {name: 'Рыба, Морепродукты', children: [
        {name: 'Замороженная рыба'},
        {name: 'Копченная, соленая, вяленная рыба'},
        {name: 'Свежая рыба'},
        {name: 'Икра'}
    ]},
    {name: 'Грибы, Ягоды', children: [
        {name: 'Свежие ягоды'},
        {name: 'Замороженные ягоды'},
        {name: 'Сущеные ягоды'},
        {name: 'Свежие грибы'},
        {name: 'Замороженные грибы'},
        {name: 'Соленые грибы'},
        {name: 'Сушенные грибы'}
    ]},
    {name: 'Напитки', children: [
        {name: 'Соки'},
        {name: 'Морс'},
        {name: 'Квас'},
        {name: 'Сиропы'},
        {name: 'Чай'}
    ]},
    {name: 'Масла, Жиры', children: [
        {name: 'Масло сливочное'},
        {name: 'Масло растительное'},
        {name: 'Жир животный'}
    ]},
    {name: 'Мясо', children: [
        {name: 'Говядина'},
        {name: 'Свинина'},
        {name: 'Баранина'},
        {name: 'Крольчатина'},
        {name: 'Субпродукты'}
    ]},
]
category_names.each_with_index do |category_name, idx|
  category = Category.create! name: category_name[:name], parent_id: 0, rank: idx + 1
  category_name[:children].each_with_index do |sub_name, sub_idx|
    category.children << Category.create!(name: sub_name[:name], parent_id: category.id, rank: sub_idx + 1)
  end
end

farmers = Farmer.all

# Products
Category.where(parent_id: 0).each do |parent|
  parent.children.each do |category|
    6.times.each do |idx|
      product = {
          name: "#{category.name} №#{idx + 1}",
          description: FFaker::HipsterIpsum.paragraph,
          category: category,
          messures: "кг",
         # image: File.open("#{Rails.root}/app/assets/images/300x300/missing.png"),
          rank: idx + 1,
          price: rand(1..10),
          farmer: farmers.sample
      }
      Product.create! product
    end
  end
end

products = Product.all
products.each do |pr|
  pr.image.attach(io: File.open("#{Rails.root}/app/assets/images/300x300/missing.png"), filename: 'missing.png')
end

# cart
users = User.all
cart_hash = []
users.each do |user|
  cart_hash << {
      user: user,
      products: 10.times.map do
        Product.all.sample
       end
      }
end

Cart.create! cart_hash

# orders

10.times.map do
  user = User.all.sample
  farmer = Farmer.all.sample
  order_hash = {
      user: user,
      farmer: farmer,
      quantity: user.cart.products.count,
      total_price: user.cart.products.sum(:price)
  }
  Order.create order_hash
end


# Pages
Page.create! name: 'main',      title: 'Ferma Store',       content: 'Текст'
Page.create! name: 'about',     title: 'О нас',             content: 'Текст'
Page.create! name: 'sellers',   title: 'Продавцам',         content: 'Текст'
Page.create! name: 'buyers',    title: 'Покупателям',       content: 'Текст'
Page.create! name: 'delivery',  title: 'Доставка и оплата', content: 'Текст'
Page.create! name: 'basket',    title: 'Корзина',           content: 'Текст'


