Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  get 'home/about', to: 'home#about', as: 'about'
  get "search" => "searches#search"

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :index, :update] do
    member do
      get :followings, :followers
      post :follow, to: 'relationships#create'
      delete :unfollow, to: 'relationships#destroy'
    end
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

end
