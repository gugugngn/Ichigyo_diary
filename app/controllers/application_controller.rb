class ApplicationController < ActionController::Base
  before_action :logout_user_if_accessing_admin
  before_action :logout_admin_if_accessing_user
  
  protected

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to posts_path, alert: 'ゲストユーザーはアクセスできません。'
    end
  end
  
  # ユーザーでログインしたまま管理者でログインさせないため記述↓
  def logout_user_if_accessing_admin
    if user_signed_in? && (request.path == new_admin_session_path)
      sign_out(current_user)
      redirect_to new_admin_session_path, alert: "管理者ログインの際は、ユーザーをログアウトする必要があります。ユーザーをログアウトしました。"
    end
  end
  
  # 管理者でログインしたままユーザーでログインさせないため記述↓
  def logout_admin_if_accessing_user
    if admin_signed_in? && (request.path == new_user_session_path || request.path == new_user_registration_path)
      sign_out(current_admin)
      redirect_to new_user_session_path, alert: "管理者からログアウトしました。"
    end
  end
  
end

