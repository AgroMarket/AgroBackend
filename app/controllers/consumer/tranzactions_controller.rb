class Consumer::TranzactionsController < ApplicationController
   # before_action :set_tranzaction, only: [:show, :update, :destroy]
    before_action :authenticate_user
    include Exceptable
  
    # GET /tranzactions
    # GET /tranzactions.json
    def index
        build do
            message "Транзакции пользователя"
            tranzactions current_user.tranzactions    
            view 'consumer/tranzactions/tranzaction'
        end
    end  
    
  end
  