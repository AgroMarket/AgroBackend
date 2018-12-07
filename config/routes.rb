Rails.application.routes.draw do
  scope :api do
    # DEVISE
    devise_for :users, controllers: { registrations: 'users/registrations' }, defaults: { format: :json }

    # AUTH
    post 'login' => 'user_token#create'

    # MEMBER
    namespace :member do
      get 'profile' => 'members#show'
      put 'profile' => 'members#update'
      resources :transactions, only: %i[create]
      resources :asks do
        resources :orders, only: %i[index show create destroy] do
          resources :order_items, only: %i[index create destroy]
        end
      end
      resources :producers, only: :index
      get 'dashboard' => 'dashboards#index'
      resources :products
      resources :orders, only: %i[index show create update destroy] do
        resources :order_items, only: %i[index create destroy]
      end
      resources :consumers, only: %i[index]

      # get 'transactions' => 'transactions#index'
      # post 'transactions' => 'transactions#create'
    end

    # post 'transactions' => 'transactions#create'
    #
    #  # USER
    # namespace :users do
    #   resources :tasks, only: %i[index update show]
    #   resources :transactions, only: %i[index]
    #   get 'profile' => 'informations#show'
    #   # get 'transactions' => 'transactions#index'
    #   # get 'tasks' => 'tasks#index'
    # end

    # # PRODUCER
    # namespace :producer do
    #   resources :products
    #   resources :asks do
    #     resources :orders, only: %i[index show update] do
    #       resources :order_items, only: %i[index]
    #     end
    #   end
    #   #  Добавил заказы для старого api по просьбе фронтенда
    #   resources :orders, only: %i[index show update] do
    #     resources :order_items, only: %i[index]
    #   end
    #   resources :transactions, only: %i[index create]
    #   get 'consumers' => 'consumers#index'
    #   get 'profile' => 'producers#show'
    #   put 'profile' => 'producers#update'
    #   get 'dashboard' => 'dashboards#index'
    # end

    # # CONSUMER
    # namespace :consumer do
    #   resources :asks do
    #     resources :orders, only: %i[index show create destroy] do
    #       resources :order_items, only: %i[index create destroy]
    #     end
    #   end
    #   # добавил, чтобы просто работало, ждём, когда пофиксится на фронте (но это не точно)
    #   resources :orders, only: %i[index show create destroy] do
    #     resources :order_items, only: %i[index create destroy]
    #   end
    #   resources :producers, only: :index
    #   get 'profile' => 'consumers#show'
    #   put 'profile' => 'consumers#update'
    #   get 'transactions' => 'transactions#index'
    #   post 'transactions' => 'transactions#create'
    # end

    # # DASHBOARD
    # get 'dashboard' => 'dashboards#index'

    # GUEST
    resources :pages,         only: %i[index show]
    resources :members,       only: %i[show create]
    resources :products,      only: %i[index show]
    resources :categories,    only: %i[index show] do
      resources :products,    only: %i[index]
    end
    resources :producers,     only: %i[show] do
      resources :products,    only: %i[index]
    end
    resources :carts,         only: %i[index show create update destroy] do
      resources :cart_items,  only: %i[index show create update destroy]
      resources :orders,      only: %i[create]
    end
    # resources :consumers, only: %i[index show create]

  end
end
