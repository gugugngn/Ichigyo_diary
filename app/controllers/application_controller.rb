class ApplicationController < ActionController::Base
  
  protected

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to posts_path, alert: 'ゲストユーザーはアクセスできません。'
    end
  end
end
