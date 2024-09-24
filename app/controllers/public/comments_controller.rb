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
    comment = @post.comments.find(params[:id])
    
    #ユーザー側と管理者側でコメント削除を可能にするため↓
    if comment.destroy
      respond_to do |format|
        format.html { redirect_to admin_user_path(comment.user), notice: "コメントが削除されました。" }
        format.js
      end
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
