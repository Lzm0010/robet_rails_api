class BetsController < ApplicationController
    def bets_by_delta
        sorted_bets = Bet.sort_active_prediction_deltas
        render json: sorted_bets.to_json(:include => {
            :event => {:only => [:home_score, :away_score], :include => {
                :league => {:only => [:name]},
                :home_team => {:only => [:name, :logo, :city, :state]},
                :away_team => {:only => [:name, :logo, :city, :state]}
            }},
            :prediction => {:only => [:away_score, :home_score]}
        }, :except => [:created_at, :updated_at, :event_id, :active])
    end

    def robet_bets
        robets_bets = Bet.sort_robets_prediction_deltas
        render json: robets_bets.to_json(:include => {
            :event => {:only => [:home_score, :away_score], :include => {
                :league => {:only => [:name]},
                :home_team => {:only => [:name, :logo, :city, :state]},
                :away_team => {:only => [:name, :logo, :city, :state]}
            }},
            :prediction => {:only => [:away_score, :home_score], :methods => :robet_record}
        }, :except => [:created_at, :updated_at, :event_id, :active])
    end
end
