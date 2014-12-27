Rails.application.routes.draw do


  get 'gifts', to: 'gifts/index', as: :gifts
  post 'gifts', to: 'gifts#create', as: :create_gift

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  root :to => "gifts#index"
end
