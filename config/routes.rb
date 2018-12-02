Rails.application.routes.draw do
  
  resources :tasks
#  resources :transactions
#  resources :asks
  scope :api do
     
    # DEVISE
    devise_for :users, controllers: { registrations: 'users/registrations' }, defaults: { format: :json }
    
    # AUTH
    post 'login' => 'user_token#create'
    post 'transactions' => 'transactions#create'
    # PRODUCER
    namespace :producer do
      resources :products
      resources :orders, only: %i[index show update] do
        resources :order_items, only: %i[index]
      end
      # resources :consumers, only: %i[index]
      get 'consumers' => 'consumers#index'      
      get 'profile' => 'producers#show'
      put 'profile' => 'producers#update'
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
    end

    # TRANZACTIONS
    # resources :tranzactions, only: :index
    # resources :orders, only: %i[index show create update] do
    #   resources :order_items
    # end
  end
end
