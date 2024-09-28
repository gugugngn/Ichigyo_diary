class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user
  before_action :ensure_correct_user, only: [:edit, :update]

  def mypage
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
    yesterday = Time.zone.today - 1
    @yesterday_post = @user.posts.find_by(created_at: yesterday.all_day)
    three_days_ago = Time.zone.today - 3
    @three_days_received_messages = @user.received_messages.where(created_at: three_days_ago.beginning_of_day..Date.today.end_of_day)
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice:"プロフィール編集の更新に成功しました！"
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
