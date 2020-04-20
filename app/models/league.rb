class League < ApplicationRecord
  belongs_to :sport
  has_many :teams
  has_many :events
  has_many :bets, through: :events
  has_many :tickets, through: :events
end
