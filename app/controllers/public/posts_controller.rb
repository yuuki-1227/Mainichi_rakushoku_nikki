class Public::PostsController < ApplicationController


  def index
    @posts = Post.all
    @tag_list = Tag.all
  end

  def favorited_ranking
    @posts = Post.all
    @tag_list = Tag.all
    # いいね数によって並び替え
    # .includes(:カラム)を指定することで、ここではfollowedsが事前に読み込まれ、
    # 無駄なSQL文が発行されないため表示速度が早くなる可能性がある
    # sortとはrubyのメソッド
    # sortの後にブロックを記述してソート方法の指定
    # a.favorited_end_users.size、b.favorited_end_users.sizeはそれぞれ各投稿のいいね数
    @favorited_ranking_posts = Post.includes(:favorited_end_users).sort {|a,b| b.favorited_end_users.size <=> a.favorited_end_users.size}
  end

  def commented_ranking
    @posts = Post.all
    @tag_list = Tag.all
    # コメント数によって並び替え
    # sortとはrubyのメソッド
    # a.commented_end_users.size、b.commented_end_users.sizeはそれぞれ各投稿のいいね数
    @commented_ranking_posts = Post.includes(:commented_end_users).sort {|a,b| b.commented_end_users.size <=> a.commented_end_users.size}
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post.tags
    @end_user = @post.end_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    # tag_list = params[:post][:name].split(nil)  # @postを参照してタグの名前も一緒に送信する。例えば「"スポーツ""勉強"」
    if @post.save                                 # split(nil):送信されてきた値を、スペースで区切って配列化する。
      tags = Vision.get_image_data(@post.image)  # save_tagはpost.rbに定義
      @post.save_tag(tags)
      redirect_to end_user_path(current_end_user)
    else
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      tags = Vision.get_image_data(@post.image)
      @post.save_tag(tags)
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_path(@post)
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end

  private

  def post_params
    params.require(:post).permit(:tag_id, :title, :explain, :image, :cooking_method, :three_meals, :release_status, :rate, :start_time)
  end

end
