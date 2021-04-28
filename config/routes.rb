Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :contacts
  devise_for :users
  devise_for :admins
  resources :users,only: [:show,:index,:edit,:update,:new,:follow]

  namespace :admin do
    resources :users
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :timeline

  root 'home#top'
  get 'home/about'
  get 'users/:user_id/follows' => 'relationships#following', as: 'followings'
  get 'users/:user_id/followers' => 'relationships#follower', as: 'followers'
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get 'search' => 'search#index'
end