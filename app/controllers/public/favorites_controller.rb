class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    # end_user(1)とfavorite(多)が関連づけられているため、buildを使用する
    # buildを使用することによってend_userに紐づけられたfavoriteインスタンスを生成することが
    favorite = current_end_user.favorites.build(post_id: params[:post_id])
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: params[:post_id], end_user_id: current_end_user.id)
    favorite.destroy
  end

end
