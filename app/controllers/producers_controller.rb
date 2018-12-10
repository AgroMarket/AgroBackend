class ProducersController < ApplicationController
  before_action :set_producer, only: :show
  include Exceptable

  # GET /producers/1
  # GET /producers/1.json
  def show
    build do
      message 'Данные производителя'
      view 'producers/show'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producer
      @producer = Member.producers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producer_params
      params.require(:producer).permit(:email, :password, :name, :phone, :address, :logo, :brand, :producer_description, :producer_address, :producer_phone, :inn)
    end
end
