class Public::RelationshipsController < ApplicationController

  def following_end_users
    @end_user = EndUser.find(params[:end_user_id])
    @end_users = @end_user.following_end_users
  end

  def follower_end_users
    @end_user = EndUser.find(params[:end_user_id])
    @end_users = @end_user.follower_end_users
  end

  def follow
    current_end_user.follow(params[:end_user_id])
    @end_user = EndUser.find(params[:end_user_id])
  end

  def unfollow
    current_end_user.unfollow(params[:end_user_id])
    @end_user = EndUser.find(params[:end_user_id])
  end

end
