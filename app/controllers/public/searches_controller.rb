class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @content = params[:content]
    
    if params[:content].present?
      @users = User.where('name LIKE ?', "%#{@content}%")
    else
      @users = User.all
    end
  end
  

end
