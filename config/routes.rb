Rails.application.routes.draw do
  scope :api do
    devise_for :users, defaults: { format: :json },
                       path_names: {
                         sign_in: 'login',
                         sign_out: 'logout',
                         sign_up: 'register'
                       }
  end
end
