Rails.application.routes.draw do

  get 'gifts', to: 'gifts#index', as: :gifts
  get 'gifts/suggest', to: 'gifts#suggest', as: :suggest_gifts
  get 'my-gifts', to: 'gifts#my_gifts', as: :my_gifts
  post 'gifts', to: 'gifts#create', as: :create_gift

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  root :to => "gifts#index"
end
