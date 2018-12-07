class Member::InflowsController < ApplicationController
  before_action :authenticate_user
  before_action :set_transaction, only: %i[show]
  include Paginable
  include Exceptable

  # GET /api/member/inflows
  # GET /api/member/inflows.json
  def index
    @pagination = nil

    build do
      message 'Список поступлений'
      path member_inflows_path
      @transactions = paginate current_user.inflows
      view 'member/inflows/index'
    end
  end

  # GET /api/member/inflows/1
  # GET /api/member/inflows/1.json
  def show
    build do
      message 'Платеж детально'
      view 'member/transactions/show'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:from_id, :to_id, :amount, :ask_id, :order_id, :status)
      #params.require(:transaction).permit(:ask_id, :status)
    end
end
