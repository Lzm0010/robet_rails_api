Rails.application.routes.draw do
  resources :tickets
  resources :bets
  resources :events
  resources :teams
  resources :leagues
  resources :sports
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
