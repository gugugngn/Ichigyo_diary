class Admin::UsersController < ApplicationController


  def index
    @users = User.all
  end

  def show
   @user = User.find(params[:id])
   @posts = @user.posts
   @comments = @user.comments
  end

  def edit
  end

  def update
  end
end
