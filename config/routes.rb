Rails.application.routes.draw do
  root to: 'home#index'

  get 'sessions/create'
  get 'sessions/destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get '/dashboard', to: 'habits#index', as: 'dashboard'
  resources :habits

end
