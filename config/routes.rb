Rails.application.routes.draw do
  root 'static_pages#home'
  
  get 'static_pages/about'

  resources :users do
    resources :relationships, only: [:create, :destroy]
  end

  resources :books do
    collection do
      get :search
    end
    resource :favorites, only: [:create, :destroy]
    resource :reviews, only: [:create, :edit, :update, :destroy]
  end

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :authors, only: [:index, :show]
end