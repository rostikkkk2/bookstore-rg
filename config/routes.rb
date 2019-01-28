Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :categories, :show
  resources :books, :show
end
