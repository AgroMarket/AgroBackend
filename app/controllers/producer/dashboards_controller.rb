class Producer::DashboardsController < ApplicationController
  before_action :authenticate_user
  include Exceptable

  def index
    @dashboard = get_info_for_dashboard
    build do
      message 'Информация для производителя'
      view 'producer/dashboards/index'
    end
  end

  private

  def get_info_for_dashboard
    {
      products_count: current_user.products.count,
      consumers_count: current_user.consumers.count,
      orders_count: current_user.orders.count,
      turnover: current_user.orders.sum(:total),
      profit: current_user.amount
    }
  end

end