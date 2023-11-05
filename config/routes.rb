Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'

  resources :users #usersヘルパーが利用可能になる

  # Defines the root path route ("/")
  # root "posts#index"
end
