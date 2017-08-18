Rails.application.routes.draw do
  devise_for :user
  resources :user
  resources :post
  resources :friend_request
  root to: 'user#index'
  get '/search', to: 'user#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
