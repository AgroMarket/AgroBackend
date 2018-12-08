class Member::MembersController < ApplicationController
  before_action :authenticate_user
  before_action :set_member, only: %i[show update]
  include Exceptable

  # GET /api/members/1
  # GET /api/members/1.json
  def show
    build do
      message    'Данные пользователя'
      view       'members/show' if current_user.member?
      view       'carrier/members/show' if current_user.carrier?
      view       'administrator/members/show' if current_user.administrator?
    end
  end

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

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
def update
  build do
    @member.update(member_params)
    message    'Данные пользователя'
    view       'members/show'
  end
end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    p current_user
    @member = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:amount, :user_type, :email, :password, :name, :address, :phone, :description, :producer_brand, :producer_address, :producer_phone, :producer_description, :producer_inn)
  end
end
