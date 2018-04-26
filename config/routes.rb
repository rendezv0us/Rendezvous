Rails.application.routes.draw do
  get 'messages/index'

  get 'messages/new'

  get 'messages/edit'

  get 'messages/check/:convo' => 'messages#check'

  resources :posts
  get 'explore/home'
  get 'explore/profile'
  get 'home/index'
  get 'home/es_index'
  post 'explore/search' => 'explore#search', as: :explore_search
  get 'explore/search/:search_word' => 'explore#search', as: :search_page
  get 'explore/search' => 'explore#home'

  root 'home#index'

  resources :messages

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
