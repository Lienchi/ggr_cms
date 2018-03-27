Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :spreadsheets, only: [:new, :create, :show] do
    resources :tags, only: [:create, :destroy]
  end
  
  root "spreadsheets#new"
end
