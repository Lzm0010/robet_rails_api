class Team < ApplicationRecord
  belongs_to :league
  has_many :events, :foreign_key => 'home_team_id'
  has_many :events, :foreign_key => 'away_team_id'
  has_many :bets, through: :events, :foreign_key => 'home_team_id'
  has_many :bets, through: :events, :foreign_key => 'away_team_id'
  has_many :tickets, through: :events, :foreign_key => 'home_team_id'
  has_many :tickets, through: :events, :foreign_key => 'away_team_id'
end
