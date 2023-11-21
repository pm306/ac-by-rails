Rails.application.routes.draw do
  get 'static_pages/home'
  get '/closet',        to: 'clothes#index',    as: 'closet'
  get '/closet/add',    to: 'clothes#new',      as: 'closet_add'
  post '/closet/add',   to: 'clothes#create',   as: 'create_cloth'
  post '/outfits',      to: 'outfit_selection_rules#select_outfit'
  get '/signup',        to: 'users#new',        as: 'signup'
  get '/login',         to: 'sessions#new',     as: 'login'
  post '/login',        to: 'sessions#create',  as: 'create_login'
  delete '/logout',     to: 'sessions#destroy', as: 'logout'
  get '/home',          to: redirect('/')

  resources :users, only:[:new, :create, :show, :edit, :update]
  resources :clothes
  resources :outfit_selection_rules, as: 'rules', path: 'rules', only:[:index, :show]

  root 'static_pages#home'
end
