class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    fermastore = User.find_by(email: 'fermastore@mail.ru')
    if @transaction.status == self.status[0]
      @transaction.from = current_user
      @transaction.to = current_user
      @transaction.amount = @transaction.ask.amount
      if @transaction.save
        render :show, status: :created, location: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
      current_user.amount += @transaction.amount
    elsif @transaction.status == self.status[1]
      @transaction.from = @transaction.ask.consumer
      @transaction.to = User.find_by(email: 'fermastore@mail.ru')
      @transaction.amount = @transaction.ask.amount  
      @transaction.save
      @transaction.ask.consumer.amount -= @transaction.amount
    elsif @transaction.status == self.status[2]
      
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    if @transaction.update(transaction_params)
      render :show, status: :ok, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      #params.require(:transaction).permit(:from_id, :to_id, :amount, :ask_id, :order_id, :status)
      params.require(:transaction).permit(:ask_id, :status)
    end
end
