class Transaction < ApplicationRecord
  belongs_to :account, class_name: 'User', foreign_key: 'account_id'
  belongs_to :from, class_name: 'User', foreign_key: 'from_id'
  belongs_to :to, class_name: 'User', foreign_key: 'to_id'
  belongs_to :ask, optional: true
  belongs_to :order, optional: true
  # belongs_to :task, optional: true

  def self.transaction_replenish(user, amount)
    member_transaction 'replenish', user, amount
  end

  def self.transaction_withdrawal(user, amount)
    member_transaction 'withdrawal', user, amount
  end

  def self.member_transaction(type, user, amount)
    hash = {
      account: user,
      t_type: type,
      direction: 'inflow',
      amount: amount,
      from: user,
      to: user,
      before: user.amount,
      after: type == 'replenish' ? user.amount + amount : user.amount - amount}
    transaction = Transaction.create!(hash)
    if transaction
      account_replenish(user, amount) if type == 'replenish'
      account_withdrawal(user, amount) if type == 'withdrawal'
    end
    transaction
  end

  def self.account_replenish(user, amount)
    user.amount += amount
    user.save
  end

  def self.account_withdrawal(user, amount)
    user.amount -= amount
    user.save
  end
end
