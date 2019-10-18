Rails.application.routes.draw do
  resources :users, only: %i(new create show update)
  resources :attractions

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  root 'sessions#new'
end
