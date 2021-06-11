class Public::EndUsersController < ApplicationController

  # 一覧画面
  def index
    @end_users = EndUser.all
  end

  # フォロワー数によって並び替え
  # sortとはrubyのメソッド
  # a.favorited_end_users.size、b.favorited_end_users.sizeはそれぞれ各投稿のいいね数
  def follower_ranking
    @follower_ranking_end_users = EndUser.includes(:followers).sort {|a,b| b.followers.size <=> a.followers.size}
  end


  # 詳細画面
  def show
    @end_user = EndUser.find(params[:id])
    @posts = Post.where(end_user_id: params[:id])
  end

  # 編集画面
  def edit
    @end_user = EndUser.find(params[:id])
  end

  # 更新機能
  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(end_user_params)
    redirect_to end_user_path(@end_user)
  end

  # 退会画面
  def unsubscribe
  end

  # 退会機能
  def withdraw
    current_end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private

  def end_user_params
    params.require(:end_user).permit(:last_name, :kana_last_name, :first_name, :kana_first_name,:profile_image, :introduction, :is_deleted)
  end

  def ensure_correct_end_user
    @post = Post.find(params[:id])
     unless @post.end_user == current_end_user
     redirect_to posts_path
     end
  end

end
