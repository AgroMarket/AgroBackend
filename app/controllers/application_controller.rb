class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Knock::Authenticable
  undef_method :current_user
  respond_to :json

  def create_transaction (from, to, amount, ask, order=nil, status)
    transaction = {
      from: from,
      to: to,
      amount: amount,
      ask: ask,
      order: order,
      status: status
    }
    Transaction.create! transaction
    if from == to
      to.amount += amount
    else
      to.amount += amount
      from.amount -= amount
    end 
  end

  def fermastore 
    User.find_by(email: 'fermastore@mail.ru')
  end

  def check_ask_status_in_order(order)
    ready_status = order.ask.orders.where(status: 1)
    order.ask.orders.count == ready_status ? true : false
  end

  def create_task(order)
    Task.create(order.ask, order.consumer)
  end
end
