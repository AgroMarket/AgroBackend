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
            view 'consumer/transactions/transaction'
        end
    end  
    
  end
  