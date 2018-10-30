Rails.application.routes.draw do
  scope :api do
    post 'login' => 'user_token#create'
    devise_for :users, defaults: { format: :json }

    # Home
    get '/home', to: 'categories#home'

    # Categories
    resources :categories, only: [:index, :show]

    # Products
    resources :products

    # Pages
    resources :pages
    end
end
