Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root 'page#index'

  resources :books, only: [:show, :index]

  # get '/comments', to: 'books#show'

  resources :comments
  resources :orders
  resources :line_items
  # get '/card/:id', to: 'cards#show', as: 'card'
  resources :carts


  resources :categories do
    resources :books, :index
  end
end
