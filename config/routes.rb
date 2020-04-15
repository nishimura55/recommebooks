Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/about'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get 'favorites/create'
  get 'favorites/destroy'

  resources :users

  resources :books do
    collection do
      get :search
    end
    resource :favorites, only: [:create, :destroy]
    resource :reviews, only: [:create, :edit, :update, :destroy]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :relationships, only: [:create, :destroy]

  resources :authors, only: [:index, :show]
  
end
