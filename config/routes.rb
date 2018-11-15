Rails.application.routes.draw do
  scope :api do
    # PRODUCER
    namespace :producer do
      resources :products
      resources :orders, only: %i[index show update]
      resources :consumers, only: %i[index]
    end
     
    post 'login' => 'user_token#create'
    devise_for :users,
               controllers: { registrations: 'users/registrations' },
               defaults: { format: :json }
    # PUBLIC

    # Pages
    resources :pages

    # Consumers
    # get 'consumer/orders' => 'orders#index'
    resources :consumers

    # Producers
    resources :producers, only: :show do
      resources :products, only: :index
    end

    # Categories
    resources :categories, only: [:index, :show] do
      resources :products, only: :index
    end

    # Products
    resources :products

    # Carts
    resources :carts, only: %i[index show create update destroy] do
      resources :cart_items
      resources :orders, only: :create
    end

    # Orders
    resources :orders, only: %i[index show create update] do
      resources :order_items
    end

    # CLIENT
    namespace :consumer do
      resources :orders, only: %i[index show create destroy]
      resources :producers, only: :index
      get 'profile' => 'consumers#show'
      put 'profile' => 'consumers#update'
    end




  end
end
