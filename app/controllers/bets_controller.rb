class BetsController < ApplicationController
    def bets_by_delta
        sorted_bets = Bet.sort_by_prediction_deltas
        render json: sorted_bets.to_json(:include => {
            :event => {:only => [:home_score, :away_score], :include => {
                :league => {:only => [:name]},
                :home_team => {:only => [:name, :logo, :city, :state]},
                :away_team => {:only => [:name, :logo, :city, :state]}
            }},
            :prediction => {:only => [:away_score, :home_score]}
        }, :except => [:created_at, :updated_at, :event_id, :active])
    end
end
