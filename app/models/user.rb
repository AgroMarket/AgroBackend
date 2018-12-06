class User < ApplicationRecord
  rolify

  # has_one :farmer
  # has_many :orders, dependent: :destroy
  # has_one :cart, dependent: :destroy
  # has_one_attached :image
  has_many :from, class_name: 'Transaction', foreign_key: 'from_id'
  has_many :to, class_name: 'Transaction', foreign_key: 'to_id'
  has_many :tasks

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

  def account_replenish(amount)
    self.amount += amount
    save
  end

  def account_withdrawal(amount)
    self.amount -= amount
    save
  end

  def transaction_replenish(amount)
    hash = {
      t_type: 'replenish',
      amount: amount,
      from: self,
      to: self,
      before: self.amount,
      after: self.amount + amount
    }
    transaction = Transaction.create!(hash)
    account_replenish(amount) if transaction
    transaction
  end

  def transaction_withdrawal(amount)
    hash = {
        t_type: 'withdrawal',
        amount: amount,
        from: self,
        to: self,
        before: self.amount,
        after: self.amount - amount
    }
    transaction = Transaction.create!(hash)
    account_withdrawal(amount) if transaction
    transaction
  end

  private

  # def assign_default_role
  #   self.add_role(:customer) if self.roles.blank?
  # end

end
