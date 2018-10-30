Rails.application.routes.draw do
  resources :pages
  scope :api do
    post 'login' => 'user_token#create'
    devise_for :users, defaults: { format: :json }

    # Home
    get '/home', to: 'categories#home'

    # Categories
    resources :categories, only: [:index, :show]
  end
end
