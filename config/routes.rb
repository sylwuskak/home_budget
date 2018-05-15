Rails.application.routes.draw do
  root to: 'categories#index'
  
  resources :categories, only: [:create, :index, :show, :destroy, :update]

end
