class Consumer::TransactionsController < ApplicationController
  # before_action :set_tranzaction, only: [:show, :update, :destroy]
  before_action :authenticate_user
  include Exceptable

  # GET /tranzactions
  # GET /tranzactions.json
  def index
    @transactions = Transaction.where(to: current_user.id)
    build do
      message "Транзакции пользователя"
      view 'producer/transactions/transaction'
    end
  end

  def show
  end

  def create
    if params[:transaction][:status] == 0
      transaction_hash = {
          amount: params[:transaction][:amount],
          from: current_user,
          to: current_user,
          ask: nil,
          order: nil,
          status: 0
      }
      transaction = Transaction.create!(transaction_hash)
      if transaction
        build do
          current_user.amount += transaction.amount
          current_user.save!
          message 'Пополнение счета покупателя'

          view 'consumer/consumers/show' if current_user.consumer?
          view 'producer/producers/show' if current_user.producer?
        end

      else
        build do
          message 'Пополнение счета покупателя'
          error @transaction.errors
          status :unprocessable_entity
          view 'consumer/consumers/consumer'
        end
      end

    elsif params[:transaction][:status] == 3
      transaction = {
          amount: params[:transaction][:amount],
          from: current_user,
          to: current_user,
          ask: nil,
          order: nil,
          status: 3
      }
      @transaction = Transaction.new(transaction)
      if current_user.amount >= @transaction.amount
        build do
          current_user.amount -= @transaction.amount
          current_user.save!
          @transaction.save!
          message 'Вывод средств покупателя'
          view 'consumer/transactions/transaction'
        end
      else
        build do
          message 'На счёте недостаточно средств'
          view 'consumer/transactions/transaction'
        end
      end
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :status)
  end

end
   