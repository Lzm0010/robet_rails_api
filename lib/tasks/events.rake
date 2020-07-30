namespace :events do
    desc "Rake task to get todays event and set the results of yesterdays events"
    task set_up_today: :environment do
        puts "Getting Yesterday's results and Today's games MLB..."
        Event.get_results("2020-07-29", 5)
        Event.get_todays_games("2020-07-30", 5)
        Prediction.get_todays_predictions("2020-07-30", 5)
        # puts "Getting Yesterday's results and Today's games NFL..."
        # Event.get_results(20190907, 3)
        # Event.get_todays_games(20190908, 3)
        # Prediction.get_todays_predictions(20190908, 3)
        # puts "Getting Yesterday's results and Today's games NBA..."
        # Event.get_results(20190907, 1)
        # Event.get_todays_games(20190908, 1)
        # Prediction.get_todays_predictions(20190908, 1)
        Bet.get_all_prediction_deltas
        puts "#{Time.now} - Yay New Day!"
    end
end

#ready to run 