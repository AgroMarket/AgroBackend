Rails.application.routes.draw do
  scope :api do
    resources :consumers
    resources :producers

    post 'login' => 'user_token#create'
    devise_for :users,
               controllers: { registrations: 'users/registrations' },
               defaults: { format: :json }

    # PUBLIC

    # Pages
    resources :pages

    # Categories
    resources :categories, only: [:index, :show] do
      resources :products, only: :index
    end

    # Products
    resources :products

    # Farmers
    resources :farmers, only: :show do
      resources :products, only: :index
    end

    # Carts
    resources :carts, only: %i[index show create update] do
      resources :cart_items
    end

    # Orders
    resources :orders, only: %i[index show create update] do
      resources :order_items
    end

    # CLIENT


    # FARMER





  end
end
