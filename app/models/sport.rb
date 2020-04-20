class Sport < ApplicationRecord
    has_many :leagues
    has_many :teams, through: :leagues
    has_many :events, through: :leagues
    has_many :bets, through: :leagues
    has_many :tickets, through: :leagues
end
