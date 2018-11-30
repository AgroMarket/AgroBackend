class TranzactionsController < ApplicationController
  before_action :set_tranzaction, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /tranzactions
  # GET /tranzactions.json
  def index
    @tranzactions = Tranzaction.all    
  end

  # GET /tranzactions/1
  # GET /tranzactions/1.json
  def show
  end

  # POST /tranzactions
  # POST /tranzactions.json
  def create
    @tranzaction = Tranzaction.new(tranzaction_params)
    if @tranzaction.save
      render :show, status: :created, location: @tranzaction
    else
      render json: @tranzaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tranzactions/1
  # PATCH/PUT /tranzactions/1.json
  def update
    if @tranzaction.update(tranzaction_params)
      render :show, status: :ok, location: @tranzaction
    else
      render json: @tranzaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tranzactions/1
  # DELETE /tranzactions/1.json
  # def destroy
  #  @tranzaction.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tranzaction
      @tranzaction = Tranzaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tranzaction_params
      params.require(:tranzaction).permit(:users_id, :sum, :to, :orders_id, :status)
    end
end
