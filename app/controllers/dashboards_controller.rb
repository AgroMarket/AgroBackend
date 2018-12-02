class DashboardsController < ApplicationController

before_action :authenticate_user
include Exceptable

def index
    @dashboard = get_info_for_dashboard
    build do 
        message "Информация для админа"
        view 'dashboards/index'
    end
end

private

def get_info_for_dashboard
    {
        total_money: Ask.sum("amount"),
        total_sales: Order.all.count,
        total_our_money: money_user.amount
    }
end

end