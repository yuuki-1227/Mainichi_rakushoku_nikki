class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def favorited_ranking
    # いいね数によって並び替え
    # sortとはrubyのメソッド
    # a.favorited_end_users.size、b.favorited_end_users.sizeはそれぞれ各投稿のいいね数
    @favorited_ranking_posts = Post.includes(:favorited_end_users).sort {|a,b| b.favorited_end_users.size <=> a.favorited_end_users.size}
  end
  
  def commented_ranking
    # コメント数によって並び替え
    # sortとはrubyのメソッド
    # a.commented_end_users.size、b.commented_end_users.sizeはそれぞれ各投稿のいいね数
    @commented_ranking_posts = Post.includes(:commented_end_users).sort {|a,b| b.commented_end_users.size <=> a.commented_end_users.size}
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    @post.save
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:genre_id, :title, :explain, :image, :cooking_method, :three_meals, :release_status, :rate)
  end

end
