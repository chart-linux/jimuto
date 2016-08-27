Rails.application.routes.draw do
  devise_for :users

  root to: "windows#index"
  resources :requests
  resources :solutions
  resources :windows
end
