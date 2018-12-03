Rails.application.routes.draw do

  scope :api do
    # DEVISE
    devise_for :users, controllers: { registrations: 'users/registrations' }, defaults: { format: :json }
    #change task

    # AUTH
    post 'login' => 'user_token#create'
    post 'transactions' => 'transactions#create'

     # USER
    namespace :users do
      resources :tasks, only: %i[index update show]
      resources :transactions, only: %i[index]
      # get 'transactions' => 'transactions#index'
      # get 'tasks' => 'tasks#index'
    end

    # PRODUCER
    namespace :producer do
      resources :products
      resources :orders, only: %i[index show update] do
        resources :order_items, only: %i[index]
      end
      resources :transactions, only: %i[index create]
      get 'consumers' => 'consumers#index'
      get 'profile' => 'producers#show'
      put 'profile' => 'producers#update'
      get 'dashboard' => 'dashboards#index'
    end

    # CONSUMER
    namespace :consumer do
      resources :asks do
        resources :orders, only: %i[index show create destroy] do
          resources :order_items, only: %i[index create destroy]
        end
      end
      resources :producers, only: :index
      get 'profile' => 'consumers#show'
      put 'profile' => 'consumers#update'
      get 'transactions' => 'transactions#index'
      post 'transactions' => 'transactions#create'
    end

    # DASHBOARD
    get 'dashboard' => 'dashboards#index'

    # GUEST
    resources :pages, only: %i[index show]
    resources :consumers, only: %i[index show create]
    resources :producers, only: %i[show] do
      resources :products, only: %i[index]
    end
    resources :categories, only: %i[index show] do
      resources :products, only: %i[index]
    end
    resources :products, only: %i[index show]
    resources :carts, only: %i[index show create update destroy] do
      resources :cart_items, only: %i[index show create update destroy]
      resources :orders, only: %i[create]
      # resources :asks, only: %i[create]
    end

    # TRANZACTIONS
    # resources :tranzactions, only: :index
    # resources :orders, only: %i[index show create update] do
    #   resources :order_items
    # end
  end
end
