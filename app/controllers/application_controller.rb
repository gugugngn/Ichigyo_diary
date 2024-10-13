class ApplicationController < ActionController::Base
  before_action :logout_user_if_accessing_admin
  
  protected

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to posts_path, alert: 'ゲストユーザーはアクセスできません。'
    end
  end
  
  def logout_user_if_accessing_admin
    if user_signed_in? && request.path.start_with?(new_admin_session_path)
      sign_out(current_user)
      redirect_to new_admin_session_path, alert: "管理者ログインの際は、ユーザーをログアウトする必要があります。ユーザーをログアウトしました。"
    end
  end
  
end

