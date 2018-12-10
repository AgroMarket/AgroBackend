class Member::DashboardsController < ApplicationController
  before_action :authenticate_user
  include Exceptable

  def index
    build do
      if current_user.member?
        @dashboard = current_user.dashboard
        message 'Сводная информация'
        view 'member/dashboards/index'
      elsif current_user.administrator?
        @dashboard = Administrator.dashboard
        message 'Информация для админа'
        view 'administrator/dashboards/index'
      end
    end
  end
end