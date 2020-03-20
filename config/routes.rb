Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get 'static_pages/about'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :users

  get 'books/search'
  get 'books/new'
  resources :books

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
end
