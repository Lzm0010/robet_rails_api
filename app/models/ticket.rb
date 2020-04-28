class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  has_one :event, through: :bet

  validates :bet_id, uniqueness: { scope: :user_id, 
    message: "You have an outstanding bet on this game" }

  def return
    if self.bet.outcome == "Win"
      if self.bet.odds > 0
        return self.amount * (self.bet.odds / 100)
      else
        return self.amount / (self.bet.odds / 100)
      end
    elsif self.bet.outcome == "Push"
      return 0
    else
      return -self.amount
    end
  end

end
