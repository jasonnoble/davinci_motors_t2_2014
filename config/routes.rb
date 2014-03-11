DavinciMotors::Application.routes.draw do
  root to: 'cars#index'

  resources :cars

  resources :users, only: [:new, :create]
end
