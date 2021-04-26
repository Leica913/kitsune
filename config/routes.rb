Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update, :new]

  resources :books do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
 end

  root 'home#top'
  get 'home/about'
  get 'users/:user_id/follows' => 'relationships#following', as: 'followings'
  get 'users/:user_id/followers' => 'relationships#follower', as: 'followers'
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get 'search' => 'search#index'
end