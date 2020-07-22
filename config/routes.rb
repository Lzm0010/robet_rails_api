Rails.application.routes.draw do
  root 'welcome#index'
  resources :relationships, only: [:create, :destroy]
  resources :tickets, only: [:create, :update, :show, :destroy]
  resources :events, only: [:index, :show]
  resources :leagues, only: [:index]
  resources :users, only: [:create, :update, :destroy, :index]
  get '/mybets', to: 'users#user_bets'
  get '/bestbets', to: 'bets#bets_by_delta'
  get '/robetbets', to: 'bets#robet_bets'
  get '/myfriends', to: 'users#my_friends'
  post '/login', to: 'auth#create'
  get '/teams/:league_id', to: 'teams#teams_by_league'
end
