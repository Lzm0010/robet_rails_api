class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def index
      users = User.where.not(id: current_user.id)
      render json: users.to_json(:include => {
        :active_relationships => {:only => [:id, :follower_id, :followed_id]}
      })
    end

    def create
        user = User.create(user_params)
        if user.valid?
          payload = {user_id: user.id}
          token = encode_token(payload)
          render json: {user:user, jwt: token}
        else
          render json: {errors: user.errors.full_messages}, status: :not_acceptable
        end
    end

    def user_bets
      render json: current_user.to_json(:include => {
        :bets => {:only => [:id, :bet_type, :position, :odds, :line, :outcome], :include => {
          :tickets => {:only => [:id, :amount, :user_id], :methods => :return},
          :event => {:only => [:home_score, :away_score, :status, :start_time], :include => {
            :league => {:only => [:name]},
            :home_team => {:only => [:name, :logo, :city, :state]},
            :away_team => {:only => [:name, :logo, :city, :state]},
            :bets => {:only => [:bet_type, :position, :odds, :line, :active]}
          }}
        }},
        :active_relationships => {:only => [:id, :follower_id, :followed_id]}
      }, :methods => :record)
    end

    def my_friends
      following = current_user.sort_friends_by_win_percentage
      render json: following.to_json(:methods => :record)
    end
    
    def update
        user = User.find(params[:id])
        if user.update_attributes(user_params)
          render json: user.to_json(:include => {
            :bets => {:only => [:id, :bet_type, :position, :odds, :line, :outcome], :include => {
              :tickets => {:only => [:id, :amount, :user_id], :methods => :return},
              :event => {:only => [:home_score, :away_score, :status, :start_time],:include => {
                :league => {:only => [:name]},
                :home_team => {:only => [:name, :logo, :city, :state]},
                :away_team => {:only => [:name, :logo, :city, :state]},
                :bets => {:only => [:bet_type, :position, :odds, :line, :active]}
              }}
            }}
          }, :methods => :record)
        else
          render json: {"message": "Something went wrong. Update was not saved."}
        end
    end

    def destroy
        user = User.find(params[:id])
        if user.destroy
            render json: user
        else
            render json: {"message": "Something went wrong. Your account was not deleted."}
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :balance)
    end
end
