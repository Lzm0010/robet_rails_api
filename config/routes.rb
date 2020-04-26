Rails.application.routes.draw do
  resources :tickets, only: [:create, :update, :show, :destroy]
  resources :events, only: [:index, :show]
  # resources :teams, only: [:index]
  resources :leagues, only: [:show]
  resources :users, only: [:create, :update, :show, :destroy]
  get '/mybets', to: 'users#user_bets'
  get '/bestbets', to: 'bets#bets_by_delta'
  post '/login', to: 'auth#create'
end
