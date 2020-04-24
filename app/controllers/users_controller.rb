class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

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

    # def show
    #     render json: current_user.to_json(:include => {
    #       :bets => {:only => [:bet_type, :position, :odds, :line, :active], :include => {
    #         :event => {:include => {
    #           :league => {:only => [:name]},
    #           :home_team => {:only => [:name, :logo, :city, :state]},
    #           :away_team => {:only => [:name, :logo, :city, :state]},
    #           :bets => {:only => [:bet_type, :position, :odds, :line, :active]}
    #         }}
    #       }}
    #     })
    # end

    def user_bets
      render json: current_user.to_json(:include => {
        :bets => {:only => [:id, :bet_type, :position, :odds, :line, :active], :include => {
          :event => {:only => [:home_score, :away_score],:include => {
            :league => {:only => [:name]},
            :home_team => {:only => [:name, :logo, :city, :state]},
            :away_team => {:only => [:name, :logo, :city, :state]},
            :bets => {:only => [:bet_type, :position, :odds, :line, :active]}
          }}
        }}
      })
    end
    
    def update
        user = User.find(params[:id])
        if user.update_attributes(user_params)
          render json: user
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
