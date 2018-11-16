Rails.application.routes.draw do
  scope :api do
     
    # DEVISE
    devise_for :users, controllers: { registrations: 'users/registrations' }, defaults: { format: :json }
    
    # AUTH
    post 'login' => 'user_token#create'
    
    # PRODUCER
    namespace :producer do
      resources :products
      resources :orders, only: %i[index show update] do
        resources :order_items, only: %i[index]
      end
      resources :consumers, only: %i[index]
      get 'profile' => 'producers#show'
      put 'profile' => 'producers#update'
    end

    # CONSUMER
    namespace :consumer do
      resources :orders, only: %i[index show create destroy] do
        resources :order_items, only: %i[index create destroy]
      end
      resources :producers, only: :index
      get 'profile' => 'consumers#show'
      put 'profile' => 'consumers#update'
    end

    # GUEST
    resources :pages, only: %i[index show]
    resources :consumers, only: %i[index show]
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
    # resources :orders, only: %i[index show create update] do
    #   resources :order_items
    # end
  end
end
