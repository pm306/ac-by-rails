Rails.application.routes.draw do
  get 'static_pages/home'
  get '/closet',        to: 'clothes#index',       as: 'closet'
  get '/closet/add',    to: 'clothes#new',         as: 'closet_add'
  post '/closet/add',   to: 'clothes#create',      as: 'create_cloth'
  post '/outfits',      to: 'outfit_selection_rules#select_outfit'
  get '/signup',        to: 'users#new',           as: 'signup'
  get '/login',         to: 'sessions#new',        as: 'login'
  post '/login',        to: 'sessions#create',     as: 'create_login'
  delete '/logout',     to: 'sessions#destroy',    as: 'logout'
  get '/deside',        to: 'static_pages#deside', as: 'deside'
  post '/deside',       to: 'clothes#update_deside', as: 'deside_push'
  get '/home',          to: redirect('/')

  resources :users,       only: %i[new create show edit update destroy]
  resources :clothes,     only: %i[index new create show edit update update_deside destroy]
  resources :cloth_types, only: %i[index new create destroy]
  resources :outfit_selection_rules, as: 'rules', path: 'rules',
                                     only: %i[index show new create destroy]
  resources :outfit_logs, only: %i[index new create show]

  root 'static_pages#home'
end
