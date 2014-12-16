Rails.application.routes.draw do
  #get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/dashboard', to: 'habits#index', as: 'dashboard'
  
  resources :habits
  
end
