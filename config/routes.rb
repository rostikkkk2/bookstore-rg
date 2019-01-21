Rails.application.routes.draw do
  root 'home#index'
  
  resources :categories, :show
  resources :books, :show
end
