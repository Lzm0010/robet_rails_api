class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :bet
  has_one :event, through: :bet

  validates :bet_id, uniqueness: { scope: :user_id, 
    message: "You have an outstanding bet on this game" }

  def return
    if self.bet.outcome == "Win"
      if self.bet.odds > 0
        profit = self.amount * (self.bet.odds / 100.00)
      else
        profit = self.amount / (-self.bet.odds / 100.00)
      end
    elsif self.bet.outcome == "Push"
      profit = 0
    else
      profit = -self.amount
    end
    return profit
  end

end
