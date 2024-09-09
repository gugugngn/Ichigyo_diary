class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @current_date = Date.today
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_message = Message.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to request.referer, alert: '入力内容に不備があります。'
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
    params.require(:post).permit(:body, :post_image, :message, mood_ids: [])
  end
end
