Rails.application.routes.draw do
  get '/closet',        to: 'clothes#index',    as: 'closet'
  get '/closet/add',    to: 'clothes#new',      as: 'closet_add'
  post '/closet/add',   to: 'clothes#create',   as: 'create_cloth'
  get '/index',         to: 'main#new',         as: 'index'
  post '/outfits',       to: 'main#select_outfit'
  get '/signup',        to: 'users#new',        as: 'signup'
  get '/login',         to: 'sessions#new',     as: 'login'
  post '/login',        to: 'sessions#create',  as: 'sessions'
  delete '/logout',     to: 'sessions#destroy', as: 'logout'

  resources :users, only:[:new, :create, :show, :edit, :update]
  resources :clothes

  # Defines the root path route ("/")
  root "main#new" 
end
