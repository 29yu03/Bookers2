Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'homes/about', to: 'homes#about', as: 'about'

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :index, :update,]
end
