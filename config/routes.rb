Rails.application.routes.draw do
  resources :tickets, only: [:create, :update, :show, :destroy]
  # resources :bets, only: [:index, :show]
  resources :events, only: [:index, :show]
  # resources :teams, only: [:index]
  resources :leagues, only: [:show]
  # resources :sports
  resources :users, only: [:create, :update, :show, :destroy]
  post '/login', to: 'auth#create'
end
