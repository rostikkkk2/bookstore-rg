Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }
  root 'page#index'
  get '/users' => redirect('users/sign_up')

  resources :books, only: [:show, :index]

  resources :comments
  resources :orders
  resources :line_items
  resources :carts
  resources :addresses
  resources :settings_emails
  resources :accounts
  resources :settings
  resources :checkout, param: :step

  resources :categories do
    resources :books, :index
  end
end
