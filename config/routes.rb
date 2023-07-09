Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "home/about"=>"homes#about"

  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create,:destroy,]
    resource :favorites, only: [:create, :destroy]
  end

  get "search" => "searches#search"

  resources :users, only: [:index,:show,:edit,:update] do
    get "search", to: "users#search"
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end

  resources :chats, only: [:show, :create]
  resources :groups, only: [:new, :create, :index, :show, :edit, :update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

