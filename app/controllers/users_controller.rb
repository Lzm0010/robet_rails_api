class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
          render json: user
        else
          render json: {"message": "Something went wrong. User was not saved."}
        end
    end

    def show
        user = User.find(params[:id])
        render json: user
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
