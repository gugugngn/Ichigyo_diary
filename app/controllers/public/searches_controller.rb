class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user
  
  def search
    @model = params[:model]
    @content = params[:content]
    
    if @model  == "user"
      if params[:content].present?
        @users = User.where('name LIKE ?', "%#{@content}%")
      else
        @users = User.all
      end
    else
      if params[:content].present?
        @posts = Post.where('body LIKE ?', "%#{@content}%").order(created_at: :desc)
        @grouped_posts = @posts.group_by { |post| post.created_at.to_date }
      else
        @posts = Post.all
      end
    end
  end
  

end
