Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'groups#index'
  resources :groups do
    resources :posts, only: [:new, :create]
  end
  resources :group_users, only: [:create, :destroy]
  namespace :account do
    resources :groups, only: :index
    resources :posts, only: :index
  end
end
