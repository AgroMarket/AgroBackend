class Producer::ProducersController < ApplicationController
  before_action :set_producer, only: [:show, :update, :destroy]
  include Exceptable

  # GET /producers/1
  # GET /producers/1.json
  def show
    build do
      message 'Профиль производителя'
      view 'producer/producers/show'
    end
  end

  # PATCH/PUT /producers/1
  # PATCH/PUT /producers/1.json
  def update
    if @producer.update(producer_params)
      build do
        message 'Редактирование профиля производителя'
        view 'producer/producers/show'
      end
    else
      build do
        message 'Редактирование профиля производителя'
        error @producer.errors
        status :unprocessable_entity
        view 'producer/producers/show'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producer
      @producer = Producer.find(current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producer_params
      params.require(:producer).permit(:email, :password, :name, :phone, :address, :producer_logo, :producer_brand, :producer_description, :producer_address, :producer_phone, :producer_inn)
    end
end
