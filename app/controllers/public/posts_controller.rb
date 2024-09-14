class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @current_date = Time.zone.today
    @post = Post.new
  end

  def index
    @posts = Post.all
    @posts = Post.latest
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
      @current_date = Time.zone.today
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user && @post.today_post?
      redirect_to post_path(@post), alert: 'この投稿は編集できません。'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_users_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :post_image, :message, mood_ids: [])
  end
end
