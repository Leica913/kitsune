Rails.application.routes.draw do

  resources :contacts

  devise_for :admins,
     path: 'auth',
     path_names: {
     sign_in: 'xxxxxxxxxx',
     sign_out: 'xxxxxxxxxx',
     password: 'xxxxxxxxxx',
     confirmation: 'xxxxxxxxxx',
     unlock: 'xxxxxxxxxx',
     registration: 'xxxxxxxxxx',
     sign_up: 'xxxxxxxxxx' },
     controllers: {
         sessions: 'admin/sessions',
         passwords: 'admin/passwords',
         registrations: 'admin/registrations',
  }
  devise_for :users

  resources :users,only: [:show,:index,:edit,:update,:new,:follow]

  namespace :admin do
    resources :users
    resources :contacts
  end

  namespace :user do
    resources :contacts
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
  get 'search' => 'search#search'
  post "contacts/thx" => "contacts#thx"
end