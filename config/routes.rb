Rails.application.routes.draw do
  devise_for :users
  root to: 'categories#index'
  
  resources :categories, only: [:create, :index, :show, :destroy, :update] do 
    collection do 
      patch 'update_configuration'
    end
  end

  resources :operations, only: [:create, :index, :show, :destroy, :update] do
    collection do 
      post 'upload'
    end
  end

end
