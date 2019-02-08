Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root 'page#index'

  resources :books, only: [:show, :index]

  resources :comments

  resources :categories do
    resources :books, :index
  end
end
