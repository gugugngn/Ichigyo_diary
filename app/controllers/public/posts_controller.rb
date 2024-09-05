class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def new
    @current_date = Date.today
  end

  def index
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@book)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body)
  end
end
