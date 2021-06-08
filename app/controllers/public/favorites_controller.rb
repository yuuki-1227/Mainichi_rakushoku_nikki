class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_end_user.favorites.build(post_id: params[:post_id])
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: params[:post_id], end_user_id: current_end_user.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end
