Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  get 'statistics', to: 'statistics#statistics', as: 'statistics'
  get 'full_statistics_image', to: 'statistics#full_statistics_image', as: 'full_statistics_image'
  get 'statistics_per_month_image', to: 'statistics#statistics_per_month_image', as: 'statistics_per_month_image'
  get 'sum_statistics', to: 'statistics#sum_statistics', as: 'sum_statistics'

  get 'calendar', to: 'calendar#show_calendar', as: 'calendar'

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

  resources :budgets, only: [:index] do 
    collection do 
      post 'budgets_create'
      post 'budgets_update'
      delete 'budgets_destroy'
    end
  end

end
