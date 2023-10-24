Rails.application.routes.draw do
  resources :favorites
  resources :ratings
  resources :genres
  # root 'pages#home'
  
  use_doorkeeper
  devise_for :users
  resources :books
  resources :movies
  # get 'pages/home'

  draw :api
end
