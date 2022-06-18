class Public::RelationshipsController < ApplicationController
  def create
    @end_user = EndUser.find(params[:end_user_id])
    relationship = current_end_user.follower.new(followed_id: @end_user.id)
    relationship.save
  end

  def destroy
    @end_user = EndUser.find(params[:end_user_id])
    relationship = current_end_user.follower.find_by(followed_id: @end_user.id)
    relationship.destroy
  end
end
