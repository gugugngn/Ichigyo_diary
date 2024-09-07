class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def mypage
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
     @user = User.find(params[:id])
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
    flash[:notice] = "ユーザーを削除しました"
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
