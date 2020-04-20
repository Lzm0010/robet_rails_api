class Bet < ApplicationRecord
  belongs_to :event
  has_many :tickets
  has_many :users, through: :tickets
end
