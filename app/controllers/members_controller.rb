class MembersController < ApplicationController
  before_action :set_member, only: :show
  include Exceptable

  # GET /api/members/1
  # GET /api/members/1.json
  def show; end

  # POST /api/members
  # POST /api/members.json
  def create
    build do
      @member   = Member.find_by(email: member_params[:email])
      @member ||= Member.create!(member_params)
      message    'Данные пользователя'
      view       'members/show'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:amount, :user_type, :email, :password, :name, :address, :phone, :description, :producer_brand, :producer_address, :producer_phone, :producer_description, :producer_inn)
  end
end
