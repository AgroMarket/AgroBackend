Rails.application.routes.draw do
  scope :api do
    post 'login' => 'user_token#create'
    devise_for :users, defaults: { format: :json }
  end
end
