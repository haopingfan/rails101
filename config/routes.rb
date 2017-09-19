Rails.application.routes.draw do
  # override omniauth_callbacks controller
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'groups#index'
  resources :groups do
    resources :posts, only: [:new, :create, :edit, :update, :destroy]
    resources :group_users, only: [:create, :destroy]
  end
  namespace :account do
    resources :groups, only: :index
    resources :posts, only: :index
  end
end
