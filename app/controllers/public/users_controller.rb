class Public::UsersController < ApplicationController
  def mypage
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
    @user = Usesr.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザーを削除しました"
    redirect_to root_path
  end
end
