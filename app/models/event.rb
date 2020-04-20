class Event < ApplicationRecord
  belongs_to :league
  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"
  has_many :bets
  has_many :tickets, through: :bets
  has_many :users, through: :bets
end
