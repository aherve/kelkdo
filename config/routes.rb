Rails.application.routes.draw do

  get 'home/index'
  resources :gifts

  post 'gifts/create', as: :create_gift

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  root :to => "gifts#index"
end
