class Event < ApplicationRecord
  belongs_to :league
  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"
  has_many :bets
  has_many :tickets, through: :bets
  has_many :users, through: :bets
  has_one :prediction

  #IDS
  #1 NBA ✅
  #2 NCAAB 
  #3 NFL
  #4 NCAAF
  #5 MLB ✅
  #6 NHL
  #7 Premier League
  #8 La Liga
  #9 Bundesliga
  #10 Serie A
  #11 Ligue 1

  def self.get_todays_games(date, league_id)
    #date should come in as no strings, YYYYMMDD, zero padded
    league_name = League.find(league_id).name
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{league_name}_Basic.csv"))
    number_of_bets = league_id == 5 ? 4 : 6
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    todays_games = csv.select{|row| row['Date'] == date.to_s}
    if todays_games.length == 0 
      return "No games today"
    end
    todays_games.each do |row|
      e = Event.new
      e.league_id = league_id
      e.home_team_id = Team.find_by(league_id: league_id, db_lookup: row['Home Team']).id
      e.away_team_id = Team.find_by(league_id: league_id, db_lookup: row['Away Team']).id
      e.start_time = row['Date']
      # e.end_time
      e.game_id = row[0] # parser for excel doesnt like first row by name
      e.status = "pending"
      e.save
      
      positions = %w(Home Away)
      over_under = %w(Over Under)
      bet_types = %w(Moneyline Total Spread)
      number_of_bets.times do |i|
        if i < 2 
          Bet.create(
            event_id: e.id,
            bet_type: bet_types[0],
            position: positions[i],
            odds: row["#{positions[i]} ML Close"],
            line: nil,
            active: true
          )
        elsif i < 4
          Bet.create(
            event_id: e.id,
            bet_type: bet_types[1],
            position: over_under[i-2],
            odds: row["#{over_under[i-2]} Close Odds"],
            line: row["#{over_under[i-2]} Close"],
            active: true
          )
        else
            Bet.create(
              event_id: e.id,
              bet_type: bet_types[2],
              position: positions[i-4],
              odds: row["#{positions[i-4]} Spread Close Odds"],
              line: row["#{positions[i-4]} Spread Close"],
              active: true
            )      
        end
      end
      
    end
  end

  def self.get_results(date, league_id)
    league_name = League.find(league_id).name
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{league_name}_Basic.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    yesterdays_games = csv.select{|row| row['Date'] == date.to_s }
    yesterdays_games.each do |row|
      e = Event.find_by(game_id: row[0])
      e.home_score = row['Home Score']
      e.away_score = row['Away Score']
      e.status = "finished"
      e.save
      e.bets.each do |bet|
        bet.get_outcome
      end
      e.bets.update(active:false)
    end
  end

  private
  
end

# Game ID	Date	Away Team	Away Score	Away ML Open	Away ML Close	Over Open	Over Open Odds	Over Close	Over Close Odds	Home Team	Home Score	Home ML Open	Home ML Close	Under Open	Under Open Odds	Under Close	Under Close Odds
