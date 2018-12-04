class Users::TransactionsController < ApplicationController
    # before_action :set_tranzaction, only: [:show, :update, :destroy]
     before_action :authenticate_user
     include Exceptable
   
     # GET /tranzactions
     # GET /tranzactions.json
     def index
        if current_user.has_role? :admin
            @transactions = Transaction.all          
        else
            @transaction = Transaction.where(to: current_user.id)
        end
        build do
            message "Транзакции всех пользователя"   
            view 'users/transactions/transaction'
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
             current_user.save
             puts current_user.amount
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
                 current_user.save
                 @transaction.save!
                 render :show, status: :created, json: @transaction
             else
                 build do
                     message "На счёте недостаточно средств"
                     view 'producer/transactions/response'
                 end
             end
         end
     end
 
     private
 
     def transaction_params
         params.require(:transaction).permit(:amount, :status)
     end
     
   end
   