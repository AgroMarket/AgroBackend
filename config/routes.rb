Rails.application.routes.draw do
  scope :api do
    post 'login' => 'user_token#create'
    devise_for :users, defaults: { format: :json }

    # Categories
    resources :categories, only: [:index, :show]
  end
end
