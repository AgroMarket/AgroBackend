class Member::DashboardsController < ApplicationController
  before_action :authenticate_user
  include Exceptable

  def index
    build do
      @dashboard = current_user.dashboard
      message 'Сводная информация'
      view 'member/dashboards/index'
    end
  end
end