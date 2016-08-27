Rails.application.routes.draw do
  devise_for :users

  root to: "windows#index"
  put 'api/:controller/:action'
  resources :requests
  resources :solutions
  resources :windows
end
