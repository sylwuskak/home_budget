Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get 'demo_version', to: 'home#demo_version', as: 'demo_version'
  
  get 'statistics', to: 'statistics#statistics', as: 'statistics'
  get 'full_statistics_image', to: 'statistics#full_statistics_image', as: 'full_statistics_image'
  get 'statistics_per_month_image', to: 'statistics#statistics_per_month_image', as: 'statistics_per_month_image'
  get 'expense_type_statistics_image', to: 'statistics#expense_type_statistics_image', as: 'expense_type_statistics_image'
  get 'sum_statistics', to: 'statistics#sum_statistics', as: 'sum_statistics'

  get 'calendar', to: 'calendar#show_calendar', as: 'calendar'

  resources :categories, only: [:create, :index, :destroy, :update] do 
    post 'set_available'
    post 'set_unavailable'
  end

  resources :operations, only: [:create, :index, :destroy, :update] do
  end

  resources :budgets, only: [:index] do 
    collection do 
      post 'budgets_create'
      post 'budgets_update'
      patch 'budgets_copy'
      delete 'budgets_destroy'
    end
  end

end
