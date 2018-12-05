class DashboardsController < ApplicationController

  before_action :authenticate_user
  include Exceptable

  def index
    @dashboard = get_info_for_dashboard
    build do
      message 'Информация для админа'
      view 'dashboards/index'
    end
  end

  private

  def get_info_for_dashboard
    {
      producers_count: Producer.count,
      consumers_count: Consumer.count,
      products_count: Product.count,
      orders_count: Order.count,
      turnover: Ask.sum(:amount),
      profit: money_user.amount
    }
  end

end