# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Role.destroy_all

def random_inn_kpp
  inn = ""
  9.times do
    inn += rand(0..9).to_s
  end
  inn
end

def add_role?(user)
  return true if user.roles.count < 2
end

users = 5.times.map do
  {
    email: FFaker::Internet.safe_email,
    fio: FFaker::NameRU.name,
    password: 'password',
    inn: random_inn_kpp,
    kpp: random_inn_kpp,
    telephone: FFaker::PhoneNumber.short_phone_number,
    region: FFaker::AddressRU.city,
    another_information: FFaker::HipsterIpsum.paragraph
  }
end

User.create! users

Role.create!(name: 'customer')
Role.create!(name: 'seller')

customers = User.first(3)
sellers = User.last(2)

customers.each do |c|
  c.roles = Role.first(1)
end

sellers.each do |s|
  s.roles = Role.last(1)
end

u = User.first
u.roles = Role.all


# Categories
Category.destroy_all
category_names = [
    {name: 'Мёд', children: [
        {name: 'Мёд'},
        {name: 'Мёд в сотах'},
        {name: 'Продукты пчеловодства'}
    ]},
    {name: 'Ягоды', children: [
        {name: 'Свежие ягоды'},
        {name: 'Замороженные ягоды'},
        {name: 'Сущеные ягоды'}
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
    {name: 'Грибы', children: [
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
    category.subcategories << Category.create!(name: sub_name[:name], parent_id: category.id, rank: sub_idx)
  end
end