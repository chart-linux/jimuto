Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users
  resources :users, :only => [:index, :show]

  root to: "windows#index"
  put 'api/:controller/:action'
  resources :requests
  resources :solutions
  resources :windows
end
