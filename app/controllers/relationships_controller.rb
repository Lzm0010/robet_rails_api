class RelationshipsController < ApplicationController
  def create
    relationship = Relationship.new(relationship_params)
    if relationship.save
      render json: relationship
    else
      render json: {errors: relationship.errors.full_messages}, status: :not_acceptable
    end
  end

  def destroy
    relationship = Relationship.find_by(followed_id: params[:id], follower_id: current_user.id)
    if relationship.follower_user == current_user
      relationship.destroy
    end
    render json: relationship
  end

  private

  def relationship_params
    params.require(:relationship).permit(:follower_id, :followed_id)
  end
end