Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'sessions/new'
  get '/login',       to: 'sessions#new'
  get '/signup',      to: 'users#new'
  get '/about',       to: "static_pages#about"
  post '/login',      to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

  resources :users
  resources :account_activations,        only: [:edit]
  resources :password_resets,            only: [:new, :create, :edit, :update]

end
