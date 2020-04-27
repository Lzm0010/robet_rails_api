class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  has_one :event, through: :bet

  validates :bet_id, uniqueness: { scope: :user_id, 
    message: "You have an outstanding bet on this game" }

    
end
