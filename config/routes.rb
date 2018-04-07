Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :spreadsheets, only: [:new, :create, :show] do
    member do
      get :js
    end    
  end

  resources :tabs, only: [] do
    member do
      get :dimension
    end    
  end


  resources :tags, only: [:update]

  root "spreadsheets#new"
end
