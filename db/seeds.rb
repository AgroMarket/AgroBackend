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
