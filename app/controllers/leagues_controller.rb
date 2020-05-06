class LeaguesController < ApplicationController
    def index
        leagues = League.all
        render json: leagues.to_json(:include => {
            :teams => {:only => [:name, :py_lookup, :logo]}
        }, :except => [:created_at, :updated_at])
    end

    def show
        league = League.find(params[:id])
        render json: league.to_json(:include => {
            :teams => {:only => [:name, :logo, :city, :state]},
            :events => {:only => [:home_team_id, :away_team_id, :start_time, :end_time, :home_score, :away_score, :status]},
            :bets => {:only => [:bet_type, :position, :odds, :line, :active]}
        }, :except => [:created_at, :updated_at])
    end  
end
