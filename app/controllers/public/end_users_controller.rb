class Public::EndUsersController < ApplicationController

  # 一覧画面
  # EndUserテーブルから.allによって全ての要素を取得
  def index
    @end_users = EndUser.all
  end

  # フォロワー数によって並び替え
  # .includes(:カラム)を指定することで、ここではfollowedsが事前に読み込まれ、
  # 無駄なSQL文が発行されないため表示速度が早くなる可能性がある
  # sortとはrubyのメソッド
  # sortの後にブロックを記述してソート方法の指定
  # a.followeds.size、b.followeds.sizeはそれぞれ各ユーザーのフォロワー数
  def follower_ranking
    @follower_ranking_end_users = EndUser.includes(:followeds).sort {|a,b| b.followeds.size <=> a.followeds.size}
  end

  def post_ranking
    @post_ranking_end_users = EndUser.includes(:posts).sort {|a,b| b.posts.size <=> a.posts.size}
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
