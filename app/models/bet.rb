class Bet < ApplicationRecord
  belongs_to :event
  has_many :tickets
  has_many :users, through: :tickets
  has_one :prediction, through: :event

  def get_prediction_delta
    case self.bet_type
    when "Moneyline"
      if self.position == "Away"
        self.prediction_delta = self.prediction.away_score - self.prediction.home_score
      else
        self.prediction_delta = self.prediction.home_score - self.prediction.away_score
      end
    when "Total"
      total_score = self.prediction.away_score + self.prediction.home_score
      if self.position == "Over"
        self.prediction_delta = total_score - self.line
      else
        self.prediction_delta = self.line - total_score
      end
    when "Spread"
      margin = (self.prediction.away_score - self.prediction.home_score).abs
      spread = self.line.abs
      if self.is_favorite?
        if margin == spread
          self.get_prediction_delta = margin - spread
        elsif self.position == "Away"
          self.prediction_delta = self.prediction.home_score > self.prediction.away_score ? -(margin + spread) : margin - spread
        else
          self.prediction_delta = self.prediction.away_score > self.prediction.home_score ? -(margin + spread) : margin - spread
        end
      else
        if margin == spread
          self.get_prediction_delta = spread - margin
        elsif self.position == "Away"
          self.prediction_delta = self.prediction.away_score > self.prediction.home_score ? (margin + spread) : spread - margin 
        else 
          self.prediction_delta = self.prediction.home_score > self.prediction.away_score ? (margin + spread) : spread - margin 
        end
      end
    else
      nil
    end
    self.save
  end

  def is_favorite?
    bet_to_compare = Bet.where.not(id: self.id).find_by(event_id: self.event_id, bet_type: self.bet_type)
    self.line < bet_to_compare.line
  end

  def self.get_all_prediction_deltas
    Bet.all.each{|bet| bet.get_prediction_delta}
  end

  def self.sort_by_prediction_deltas
    Bet.all.sort_by{|bet| bet.prediction_delta}.reverse!
  end

end
