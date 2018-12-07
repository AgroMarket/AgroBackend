class Transaction < ApplicationRecord
  belongs_to :account, class_name: 'User', foreign_key: 'account_id'
  belongs_to :from, class_name: 'User', foreign_key: 'from_id'
  belongs_to :to, class_name: 'User', foreign_key: 'to_id'
  belongs_to :ask, optional: true
  belongs_to :order, optional: true
  # belongs_to :task, optional: true

  # Резервирование средств
  def self.transaction_reserve(user, ask)
    transactions = []
    system = Administrator.first

    hash = {
      account: user,
      t_type: 'reserve',
      direction: 'outflow',
      amount: ask.total,
      from: user,
      to: system,
      before: user.amount,
      after: user.amount - ask.total,
      ask: ask
    }
    outflow = Transaction.create!(hash)
    account_withdrawal(user, ask.total) if outflow

    hash = {
      account: system,
      t_type: 'reserve',
      direction: 'inflow',
      amount: ask.total,
      from: user,
      to: system,
      before: system.amount,
      after: system.amount + ask.total,
      ask: ask
    }
    inflow = Transaction.create!(hash)
    account_replenish(system, ask.total) if inflow

    transactions.push outflow, inflow
    transactions
  end

  # Пополнение и снятие
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
      direction: type == 'replenish' ? 'inflow' : 'outflow',
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
