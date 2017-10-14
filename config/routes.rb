Rails.application.routes.draw do
  get 'explore/home'
  get 'home/index'
  root 'home#index'

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
