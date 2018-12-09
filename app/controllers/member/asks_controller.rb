class Member::AsksController < ApplicationController
  before_action :authenticate_user
  before_action :set_ask, only: [:show, :update, :destroy]
  include Exceptable
  include Paginable

  # GET /asks
  # GET /asks.json
  def index
    @pagination = nil

    build do
      if params[:scope] == 'pending'
        message 'Упаковываются'
        @asks = Ask.by_consumer_and_status(current_user, 0)

      elsif params[:scope] == 'confirmed'
        message 'Доставляются'
        @asks = Ask.by_consumer_and_status(current_user, 1)

      elsif params[:scope] == 'completed'
        message 'Доставлены'
        @asks = Ask.by_consumer_and_status(current_user, 2)
      elsif params[:scope] == 'declained'
        message 'Отклонены'
        @asks = Ask.by_consumer_and_status(current_user, 3)  
      else
        message 'Список покупок'
        @asks = Ask.by_consumer(current_user)
      end

      @asks_count = @asks.size
      path member_asks_path
      @asks = paginate @asks
      view 'member/asks/index'
    end
  end

  # GET /asks/1
  # GET /asks/1.json
  def show
    build do
      message 'Заказ покупателя детально'
      view 'member/asks/show'
    end
  end

  # # PATCH/PUT /asks/1
  # # PATCH/PUT /asks/1.json
  # def update
  #   if params[:ask][:status] == 2 && @ask.status != 2
  #     @ask.orders.each do |order|
  #       create_transaction(fermastore, order.producer, (order.total*0.9).to_i, @ask, order, 2)
  #     end
  #     create_transaction(fermastore, money_user, (@ask.amount*0.1).to_i, @ask, nil, 2)
  #     create_transaction(fermastore, tk_user, 500, @ask, nil, 2)
  #     if @ask.update(ask_params)
  #       build do
  #         message 'Статус заказа изменен'
  #         view 'consumer/asks/show'
  #       end
  #     else
  #       render json: @ask.errors, status: :unprocessable_entity
  #     end
  #   end
  # end

  # DELETE /asks/1
  # DELETE /asks/1.json
  def destroy
    if @ask.destroy
      build do
        message 'Заказ покупателя детально'
        view 'member/asks/show'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask
      @ask = Ask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ask_params
      params.require(:ask).permit(:amount, :status)
    end
end
