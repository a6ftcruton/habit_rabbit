


Rails.application.routes.draw do
  root to: 'home#index'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'sessions/create'
  get 'sessions/destroy'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get '/dashboard', to: 'habits#index', as: 'dashboard'

  post 'twilio/voice' => 'twilio#voice'

  resources :habits
  resources :users, only: [:update]


  post '/add_github', to: 'habits#add_github', as: 'add_github'
  post '/add_notification', to: 'habits#add_notification', as: 'add_notification'
end
