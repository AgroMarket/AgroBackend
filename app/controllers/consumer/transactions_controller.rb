class Consumer::TransactionsController < ApplicationController
   # before_action :set_tranzaction, only: [:show, :update, :destroy]
    before_action :authenticate_user
    include Exceptable
  
    # GET /tranzactions
    # GET /tranzactions.json
    def index
        @transactions = Transaction.where(from: current_user.id) 
        build do
            message "Транзакции пользователя"   
            view 'consumer/transactions'
        end
    end  

    def show
    end

    def create
        @transaction = Transaction.new(transaction_params)
        if @transaction.status == "Пополнение"
            @transaction.from = current_user
            @transaction.to = current_user
            @transaction.ask = nil
            @transaction.order = nil
            current_user.amount += @transaction.amount
            if @transaction.save!
                render :show, status: :created, json: @transaction
            else
                render json: @transaction.errors, status: :unprocessable_entity
            end
        elsif @transaction.status == "Вывод"
            @transaction.from = current_user
            @transaction.to = current_user
            @transaction.ask = nil
            @transaction.order = nil
            if current_user.amount >= @transaction.amount 
                current_user.amount -= @transaction.amount
                @transaction.save!
                render :show, status: :created, json: @transaction
            else
                render json: @transaction.errors, status: :unprocessable_entity
            end
        end
    end

    private

    def transaction_params
        params.require(:transaction).permit(:amount, :status)
    end
    
  end
  