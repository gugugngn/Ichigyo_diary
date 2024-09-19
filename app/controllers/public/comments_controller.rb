class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    unless @comment.save
      render 'error'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(id: params[:id], post_id:params[:post_id]).destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
