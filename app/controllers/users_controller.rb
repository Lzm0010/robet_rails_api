class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        user = User.create(user_params)
        if user.valid?
          token = encode_token(user_id: user.id)
          render json: {user:user, jwt: token}
        else
          render json: {error: "Failed to create user."}, status: :not_acceptable
        end
    end

    def show
        render json: {user: current_user}
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
