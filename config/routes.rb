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
  get 'sessions/signin', to: 'sessions#signin', as: 'signin'
  post 'sessions/login', to: 'sessions#login', as: 'login'

  resources :users

  resources :habits do
    resources :events, only: [:create]
  end

  post '/track_repo', to: 'habits#track_repo', as: 'track_repo'

  post '/add_github', to: 'users#add_github', as: 'add_github'

  namespace :api do
    namespace :v1 do
      resources :habits, only: [:index, :show]
      resources :events, only: [:index, :show]
    end
  end

  post '/dashboard', to: 'habits#update_notifications', as: 'habit_update_notification'
end
