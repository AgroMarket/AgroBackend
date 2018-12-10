class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Knock::Authenticable
  undef_method :current_user
  respond_to :json

  def create_transaction (from, to, amount, ask, order = nil, status)
    transaction = {
      from: from,
      to: to,
      amount: amount,
      ask: ask,
      order: order,
      status: status
    }
    result = Transaction.create! transaction
    if from == to
      to.amount += amount
      to.save
    else
      to.amount += amount
      from.amount -= amount
      to.save
      from.save
    end
    result
  end

  def fermastore 
    User.find_by(email: 'fermastore@mail.ru')
  end

  def money_user 
    User.find_by(email: 'money@mail.ru')
  end

  def tk_user 
    User.find_by(email: 'transport@mail.ru')
  end

  # def check_ask_status_in_order(order)
  #   order.ask.orders.count == order.ask.orders.where(status: 1).count
  # end
  #
  # def create_task(order)
  #   Task.create(ask: order.ask, user: order.consumer, status: 0)
  # end
end
