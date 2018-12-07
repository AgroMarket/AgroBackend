class User < ApplicationRecord
  rolify

  # has_one :farmer
  # has_many :orders, dependent: :destroy
  # has_one :cart, dependent: :destroy
  # has_one_attached :image
  # has_many :from, class_name: 'Transaction', foreign_key: 'from_id'
  # has_many :to, class_name: 'Transaction', foreign_key: 'to_id'
  # has_many :tasks

  # after_create :assign_default_role

  # before_create :skip_confirmation_notification!
  # before_update :skip_confirmation_notification!

  # Include default devise modules. Others available are: :confirmable,
    # :lockable, :timeoutable, :trackable, :omniauthable,
  devise :database_authenticatable, :registerable, :rememberable,
         :validatable, :recoverable


  alias_method :authenticate, :valid_password?

  def self.from_token_payload(payload)
    self.find payload['sub']
  end

  def consumer?
    type == 'Consumer'
  end

  def producer?
    type == 'Producer'
  end

  def enough_money?(cart)
    amount >= cart.total
  end

  def payments
    Transaction.where(account: self, direction: 'outflow')
  end
end
