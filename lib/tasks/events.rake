namespace :events do
    desc "Rake task to get todays event and set the results of yesterdays events"
    task set_up_today: :environment do
        puts "Getting Yesterday's results and Today's games..."
        Event.get_results(20190825, 5)
        Event.get_todays_games(20190826, 5)
        Prediction.get_todays_predictions(20190826, 5)
        Bet.get_all_prediction_deltas
        puts "#{Time.now} - Yay New Day!"
    end
end