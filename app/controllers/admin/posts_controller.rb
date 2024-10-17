class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_user_path(@post.user), notice: "投稿を削除しました。"
    else
      redirect_to request.referer, alert: "投稿の削除に失敗しました。"
    end
  end
end
