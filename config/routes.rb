Rails.application.routes.draw do
  resources :tickets, only: [:create, :update, :show, :destroy]
  # resources :bets, only: [:index, :show]
  resources :events, only: [:index, :show]
  # resources :teams, only: [:index]
  resources :leagues, only: [:show]
  # resources :sports
  resources :users, only: [:create, :update, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
