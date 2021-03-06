class Public::PostCommentsController < ApplicationController

  # 新規投稿コメント登録
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_end_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      redirect_back(fallback_location: root_path)
    else
      @end_user = @post.end_user
      @post_new = Post.new
      # 違うコントローラ(postコントローラ)のshowアクションのレビューを表示
      render template "public/posts/show"
    end
  end

  # 既存投稿コメント削除
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
