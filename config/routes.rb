Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  get 'statistics', to: 'statistics#statistics', as: 'statistics'
  get 'statistics_image', to: 'statistics#statistics_image', as: 'statistics_image'

  resources :categories, only: [:create, :index, :destroy, :update] do 
    collection do 
      patch 'update_configuration'
    end
  end

  resources :operations, only: [:create, :index, :destroy, :update] do
    collection do 
      post 'upload'
    end
  end

end
