Rails.application.routes.draw do
  devise_for :users
  root to: 'categories#index'
  
  resources :categories, only: [:create, :index, :show, :destroy, :update]
  resources :operations, only: [:create, :index, :show, :destroy, :update]

end
