class Member::ConsumersController < ApplicationController
  before_action :authenticate_user
  before_action :set_consumer, only: %i[show]
  include Paginable
  include Exceptable

  # GET /consumers
  # GET /consumers.json
  def index
    @pagination = nil

    build do
      message 'Список покупателей'
      path member_consumers_path
      @consumers = paginate current_user.buyers
      view 'member/consumers/index'
    end
  end

  # # GET /api/members/1
  # # GET /api/members/1.json
  # def show
  #   build do
  #     message 'Покупатель детально'
  #     @consumers = paginate current_user.buyers
  #     view 'member/consumers/show'
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer
      @consumer = Member.find(params[:id])
    end
end
