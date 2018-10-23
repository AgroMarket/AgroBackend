Rails.application.routes.draw do
  resources :categories
  scope :api do
    post 'login' => 'user_token#create'
    devise_for :users, defaults: { format: :json }
  end
end
