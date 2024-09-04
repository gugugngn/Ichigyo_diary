class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def new
  end

  def index
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
