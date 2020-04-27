class Prediction < ApplicationRecord
  belongs_to :event
  has_many :bets, through: :event

  def self.get_todays_predictions(date, league_id)
    league_name = League.find(league_id).name
    todays_games = Event.where(start_time: date)

    todays_games.each do |game|
      p = Prediction.new
      p.event_id = game.id
      away_team = Team.find(game.away_team_id).lookup
      home_team = Team.find(game.home_team_id).lookup
      if away_team == "WSH"
        away_team = "WSN"
      end
      if away_team == "CWS"
        away_team = "CHW"
      end
      if home_team == "WSH"
        home_team = "WSN"
      end
      if home_team == "CWS"
        home_team = "CHW"
      end
      predictions = JSON.parse(ApiCaller.api_request("http://localhost:5000/#{league_name}/#{away_team}/#{home_team}"))
      p.home_score = predictions[home_team]['predicted_score'][0]
      p.home_confidence = predictions[home_team]['confidence']
      p.away_score = predictions[away_team]['predicted_score'][0]
      p.away_confidence = predictions[away_team]['confidence']
      p.save
    end
  end

  def self.robet_record
    {
      "wins": self.robet_wins,
      "losses": self.robet_losses,
      "ties": self.robet_ties
    }
  end

  def self.robet_wins
    Prediction.joins(:bets).where("bets.prediction_delta > 0").where("bets.outcome" => "Win").count
  end
  
  def self.robet_losses
    Prediction.joins(:bets).where("bets.prediction_delta > 0").where("bets.outcome" => "Loss").count
  end
  
  def self.robet_ties
    Prediction.joins(:bets).where("bets.prediction_delta > 0").where("bets.outcome" => "Push").count
  end

end
