class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user
  before_action :ensure_correct_user, only: [:edit, :update]

  def mypage
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
    @random_post = @user.posts.shuffle.first
    @yesterday_post = @user.yesterday_post
    @three_days_received_messages = @user.three_days_received_messages
    @three_days_sent_messages = @user.three_days_sent_messages
  end

  def favorites
    @user = User.find(params[:id])
    @favorite_posts = Post.joins(:favorites)
                          .where(favorites: { user_id: @user.id })
                          .order('favorites.created_at DESC')
                          .page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.public_posts.order(created_at: :desc).page(params[:page])
    @three_days_received_messages = @user.three_days_received_messages

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to mypage_users_path, notice:"プロフィール編集の更新に成功しました！"
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # 現在ログインしているユーザーだけを許可↓
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to mypage_users_path
    end
  end
end
