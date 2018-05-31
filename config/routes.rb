Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  get 'statistics', to: 'statistics#statistics', as: 'statistics'
  get 'full_statistics_image', to: 'statistics#full_statistics_image', as: 'full_statistics_image'
  get 'statistics_per_month_image', to: 'statistics#statistics_per_month_image', as: 'statistics_per_month_image'

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

  resources :budgets, only: [:create, :index, :destroy, :update] do 
    collection do 
      post 'budgets_create'
    end
  end

end
