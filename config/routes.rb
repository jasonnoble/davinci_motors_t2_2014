DavinciMotors::Application.routes.draw do
  root to: 'cars#index'

  resources :cars

  resources :users, only: [:new, :create]

  get 'login',
      to: 'sessions#login',
      as: 'login'

  post 'login',
       to: 'sessions#create'

  delete 'logout',
         to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#oauth'
end
