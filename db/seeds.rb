require 'csv'

## SEED SPORTS 
sports = %w(Basketball Football Baseball Hockey Soccer)
sports.each{|sport| Sport.create(name: sport)}

## SEED BASKETBALL LEAGUES
bball_leagues = %w(NBA CBB)
bball_leagues.each{|league| League.create(name: league, sport_id:1)}

## SEED FOOTBALL LEAGUES
fball_leagues = %w(NFL CFB)
fball_leagues.each{|league| League.create(name: league, sport_id:2)}

## SEED BASEBALL LEAGUES
bsbll_leagues = %w(MLB)
bsbll_leagues.each{|league| League.create(name: league, sport_id:3)}

## SEED HOCKEY LEAGUES
hockey_leagues = %w(NHL)
hockey_leagues.each{|league| League.create(name: league, sport_id:4)}

## SEED SOCCER LEAGUES
soccer_leagues = ['Premier Leauge', 'La Liga', 'Bundesliga', 'Serie A', 'Ligue 1']
soccer_leagues.each{|league| League.create(name: league, sport_id:5)}
 
## SEED TEAMS ALL SPORTS
csv_text = File.read(Rails.root.join('lib', 'seeds', 'teams.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    t = Team.new
    t.name = row[0]
    t.db_lookup = row['db_lookup']
    t.py_lookup = row['py_lookup']
    t.logo = row['logo']
    t.city = row['city']
    t.state = row['state']
    t.league_id = row['league_id']
    t.save
end

puts "There are now #{Team.count} rows in the teams table. seed success!"

## SEED USERS
u1 = User.create(username: "lee", 
    email: "email@gmail.com", 
    password: "poo",
    balance: 0)
u2 = User.create(username: "danny", 
    email: "haha@gmail.com", 
    password: "poo",
    balance: 0
)
u3 = User.create(username: "frankie", 
    email: "a@g.com", 
    password: "poo",
    balance: 0
)



