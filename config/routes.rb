Rails.application.routes.draw do
  devise_for :user, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }
  resources :user
  resources :post
  resources :friend_request
  root to: 'user#index'
  get '/search', to: 'user#search'
  get '/requests', to: 'user#requests'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
