Rails.application.routes.draw do
  get 'messages/index'

  get 'messages/new'

  get 'messages/edit'

  get 'messages/check/:convo' => 'messages#check'

  post 'messages/delete_convo' => 'messages#delete_convo', as: :delete_convo

  resources :posts
  get 'populate' => 'posts#populate'
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
