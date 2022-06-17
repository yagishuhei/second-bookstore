class Public::RelationshipsController < ApplicationController
  def create
    current_end_user.follow(params[:end_user_id])
    @end_user = current_end_user

  end

  def destroy
    current_end_user.unfollow(params[:end_user_id])
     @end_user = current_end_user
  end


  def follows
    end_user = EndUser.find(params[:id])
    @end_users = end_user.following_end_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    end_user = EndUser.find(params[:id])
    @end_users = end_user.follower_end_user.page(params[:page]).per(3).reverse_order
  end
end
