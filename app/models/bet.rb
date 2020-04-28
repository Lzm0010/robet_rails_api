class Bet < ApplicationRecord
  belongs_to :event
  has_many :tickets
  has_many :users, through: :tickets
  has_one :prediction, through: :event

  ##### PREDICTION DELTA METHODS #####

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

  
  def self.get_all_prediction_deltas
    Bet.all.each{|bet| bet.prediction_delta == nil ? bet.get_prediction_delta : nil}
  end
  
  def self.sort_by_prediction_deltas
    Bet.where(active: true).sort_by{|bet| bet.prediction_delta}.reverse!
  end

  ###### BET OUTCOME METHODS ######

  def moneyline_outcome
    if self.game_winner?
      self.outcome = "Win"
    else
      self.outcome = "Loss"
    end
    self.save
  end

  def total_outcome
    total_score = self.event.home_score + self.event.away_score
    if self.position == "Over"
      if total_score > self.line
        self.outcome = "Win"
      elsif total_score == self.line
        self.outcome = "Push"
      else
        self.outcome = "Loss"
      end
    else
      if total_score > self.line
        self.outcome = "Loss"
      elsif total_score == line
        self.outcome = "Push"
      else
        self.outcome = "Win"
      end
    end
    self.save
  end

  def spread_outcome
    margin = (self.event.home_score - self.event.away_score).abs
    spread = self.line.abs
    if margin == spread
      self.outcome = "Push"
    elsif margin > spread
      if self.game_winner?
        self.outcome = "Win"
      else
        self.outcome = "Loss"
      end
    else
      if self.is_favorite?
        self.outcome = "Loss"
      else
        self.outcome = "Win"
      end
    end
    self.save
  end

  def get_outcome
    case self.bet_type
    when "Moneyline"
      self.moneyline_outcome
    when "Total"
      self.total_outcome
    when "Spread" 
      self.spread_outcome
    end
  end


  ##### HELPER METHODS ######

  def is_favorite?
    bet_to_compare = Bet.where.not(id: self.id).find_by(event_id: self.event_id, bet_type: self.bet_type)
    self.line < bet_to_compare.line
  end

  def game_winner?
    self.position == "Away" && self.event.away_score > self.event.home_score || self.position == "Home" && self.event.home_score > self.event.away_score
  end

end
