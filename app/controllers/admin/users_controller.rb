class Admin::UsersController < ApplicationController
before_action :authenticate_admin!

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @comments = @user.comments
  end

  def edit
  end

  def update
  end
end
