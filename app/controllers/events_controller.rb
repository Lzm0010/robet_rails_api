class EventsController < ApplicationController
    def index
        events = Event.all
        render json: events.to_json(:include => {
            :league => {:only => [:name]},
            :home_team => {:only => [:name, :logo, :city, :state]},
            :away_team => {:only => [:name, :logo, :city, :state]},
            :bets => {:only => [:id, :bet_type, :position, :odds, :line, :active]}
        }, :except => [:created_at, :updated_at])
    end

    def show
        event = Event.find(params[:id])
        render json: event.to_json(:include => {
            :league => {:only => [:name]},
            :home_team => {:only => [:name, :logo, :city, :state]},
            :away_team => {:only => [:name, :logo, :city, :state]},
            :bets => {:only => [:bet_type, :position, :odds, :line, :active]}
        }, :except => [:created_at, :updated_at])
    end
    
end
