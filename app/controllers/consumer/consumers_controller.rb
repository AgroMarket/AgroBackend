class Consumer::ConsumersController < ApplicationController
  before_action :authenticate_user
  before_action :set_consumer, only: [:show, :update, :destroy]
  include Exceptable
  include Paginable

  # GET /consumers
  # GET /consumers.json
  # добавил данный метод, т.к. происходит баг, когда
  # при просмотре страницы с покупателями у продавца
  # обращение идёт к данному контроллеру, а не к контроллеру
  # в producers
  
  def index
    @pagination = nil
    build do
      message 'Список покупателей (consumers)'
      @consumers = paginate current_user.consumers.distinct
      view 'producer/consumers/index'
    end
  end

  # GET /consumers
  # GET /consumers.json
  # def index
  #   @consumers = Consumer.all
  # end

  # GET /consumers/1
  # GET /consumers/1.json
  def show
    if current_user.consumer?
      build do
        message 'Профиль покупателя'
        view 'consumer/consumers/show'
      end
    end

    if current_user.producer?
      build do
        message 'Профиль производителя'
        view 'producer/producers/show'
      end
    end
  end

  # POST /consumers
  # POST /consumers.json
  # def create
  #   @consumer = Consumer.new(consumer_params)

  #   if @consumer.save
  #     @consumer.image.attach(
  #       io: File.open("#{Rails.root}/app/assets/images/300x300/missing.png"),
  #       filename: 'missing.png'
  #     )
  #     build do
  #       message 'Создание нового пользователя'
  #       view 'consumers/show'
  #     end
  #     # render :show, status: :created, location: @consumer
  #   else
  #     render json: @consumer.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /consumers/1
  # PATCH/PUT /consumers/1.json
  def update
    if @consumer.update(consumer_params)
      current_user.type = params[:consumer][:type]
      build do
        message 'Редактирование профиля покупателя'
        view 'consumer/consumers/show'
      end
    else
      render json: @consumer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /consumers/1
  # DELETE /consumers/1.json
  # def destroy
  #   @consumer.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer
      if current_user
        @consumer = Consumer.find(current_user.id)
      else
        @consumer = Consumer.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_params
      params.require(:consumer).permit(:email, :password, :name, :phone, :address, :type)
    end
end
