class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user, except: [:index]


  def new
    @current_date = Time.zone.today
    @post = Post.new
  end

  def index
    @posts = Post.public_posts.order(created_at: :desc).page(params[:page])
    @grouped_posts = @posts.group_by { |post| post.created_at.to_date }
  end

  def show
    @post = Post.find(params[:id])
    @post_message = Message.new
    @comment = Comment.new

    unless @post.is_public || @post.user == current_user
      redirect_to posts_path, alert: "この投稿は非公開です。"
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
       redirect_to post_path(@post), alert: '日記を投稿しました。本日もお疲れ様でした！'
    else
      @current_date = Time.zone.today
      respond_to do |format|
        format.js { render 'error' } # エラーメッセージをJavaScriptに返す
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(@post), alert: 'この投稿は編集できません。'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新しました。"
    else
      respond_to do |format|
        format.js { render 'error' } # エラーメッセージをJavaScriptに返す
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    # @post.destroy
    # redirect_to mypage_users_path

    if @post.destroy
      respond_to do |format|
        format.html { redirect_to mypage_users_path }
        format.html { redirect_to request.referer, notice: "コメントが削除されました。" }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :post_image, :message, :is_public, mood_ids: [])
  end
end
