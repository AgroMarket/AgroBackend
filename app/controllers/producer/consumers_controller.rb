class Producer::ConsumersController < ApplicationController
  before_action :set_consumer, only: [:show, :update, :destroy]
  include Paginable
  include Exceptable

  # GET /consumers
  # GET /consumers.json
  def index
    @pagination = nil

    build do
      message 'Список покупателей'
      @consumers = paginate current_user.consumers.distinct
      view 'producer/consumers/index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer
      @consumer = Consumer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_params
      params.require(:consumer).permit(:email, :password, :name, :phone, :address)
    end
end
