class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to request.referer, notice: "投稿を削除しました。"
    else
      redirect_to request.referer, alert: "投稿の削除に失敗しました。"
    end
  end
end
