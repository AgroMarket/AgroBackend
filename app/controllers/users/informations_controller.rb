class Users::InformationsController < ApplicationController
before_action :set_user
before_action :authenticate_user
include Exceptable

def show
    build do
        message "Профиль пользователя"
        view 'users/user/profile'
    end
end

private

def set_user
    @user = User.find(current_user.id)
end

end