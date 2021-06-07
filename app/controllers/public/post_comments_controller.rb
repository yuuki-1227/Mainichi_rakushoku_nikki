class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_end_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save

    else
      @end_user = @post.end_user
      @post_new = Post.new
      render template "public/posts/show"
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
