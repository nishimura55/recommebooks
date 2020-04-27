Rails.application.routes.draw do

  root 'static_pages#home'
  get 'static_pages/about'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    resources :relationships, only: [:create, :destroy]
    resources :recommends, only: :index
  end

  resources :recommends, only: [:new, :create, :update]
  namespace :recommends do
    resources :users, only: :index
    resources :books, only: :index
  end

  resources :books do
    collection do
      get :search
    end
    resource :favorites, only: [:create, :destroy]
    resource :reviews, only: [:create, :edit, :update, :destroy]
  end

  resources :authors, only: [:index, :show]

  resources :notifications, only: :index

end