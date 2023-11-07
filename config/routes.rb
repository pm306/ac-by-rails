Rails.application.routes.draw do
  get '/closet',        to: 'clothes#index',    as: 'closet'
  get '/closet/detail', to: 'clothes#new',      as: 'closet/detail'
  get '/index',         to: 'main#new',         as: 'index'
  get '/signup',        to: 'users#new',        as: 'signup'
  get '/login',         to: 'sessions#new',     as: 'login'
  post '/login',        to: 'sessions#create',  as: 'sessions'
  delete '/logout',     to: 'sessions#destroy', as: 'logout'

  resources :users, only:[:new, :create] #usersヘルパーが利用可能になる

  # Defines the root path route ("/")
  root "main#new" 
end
