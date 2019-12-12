Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :clients
  resources :car_models
  resources :rentals do
    get 'search', on: :collection
    put 'confirm', on: :member
  end
  resources :cars, only:[:index, :new, :create, :show]  
end
