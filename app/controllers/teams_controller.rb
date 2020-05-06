class TeamsController < ApplicationController
    def teams_by_league
        teams = Team.all.where(league_id: params[:league_id])
        render json: teams
    end
end
