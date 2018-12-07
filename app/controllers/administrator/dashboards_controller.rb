class Administrator::DashboardsController < ApplicationController

  before_action :authenticate_user
  include Exceptable

  def index
    @dashboard = get_info_for_dashboard
    build do
      message 'Информация для админа'
      view 'administrator/dashboards/index'
    end
  end

  private

  def get_info_for_dashboard
    {
      producers_count: Member.producers.count,
      consumers_count: Member.consumers.count,
      products_count: Product.count,
      orders_count: Order.count,
      turnover: Ask.sum(:total),
      profit: Administrator.second.amount
    }
  end

end