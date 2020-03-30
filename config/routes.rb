Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root 'static_pages#home'

  get 'static_pages/about'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :users

  resources :books do
    collection do
      get :search
    end
    resource :favorites, only: [:create, :destroy]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :relationships, only: [:create, :destroy]
  
end
