class AsksController < ApplicationController
  before_action :set_ask, only: [:show, :update, :destroy]

  # GET /asks
  # GET /asks.json
  def index
    @asks = Ask.includes(:orders).order('created_at DESC')
  end

  # GET /asks/1
  # GET /asks/1.json
  def show
  end

  # POST /asks
  # POST /asks.json
  def create
    @ask = Ask.new(ask_params)
    #fermastore = User.find_by(email: 'fermastore@mail.ru')
    if @ask.save
      render :show, status: :created, location: @ask
    else
      render json: @ask.errors, status: :unprocessable_entity
    end
    #self.create_transaction(from: current_user, to: current_user, amount: @ask.amount, ask: @ask, status: 0)
  end

  # PATCH/PUT /asks/1
  # PATCH/PUT /asks/1.json
  def update
    if @ask.update(ask_params)
      render :show, status: :ok, location: @ask
    else
      render json: @ask.errors, status: :unprocessable_entity
    end
  end

  # DELETE /asks/1
  # DELETE /asks/1.json
  def destroy
    @ask.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask
      @ask = Ask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ask_params
      params.require(:ask).permit(:date, :amount, :status)
    end
end
