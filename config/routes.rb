Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :spreadsheets, only: [] do
    collection do
      get :pdf
      get :js
      get :copy
    end    
  end

  resource :tabs, only: [:create, :update] do
    collection do 
      post :dimension
      post :hide
    end
  end
  
  resource :tags, only: [:create, :update, :destroy]

  root "spreadsheets#index"
end
