class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user
  
  def search
  @model = params[:model]
  @content = params[:content].to_s.strip  # 検索キーワードの前後の空白を削除

  if @model == "user"
    if @content.blank?
      redirect_to request.referer, notice: "検索キーワードを入力してください。"
    else
      @users = User.where('name LIKE ?', "%#{@content}%").order(created_at: :desc).page(params[:page])
    end
  else
    if @content.blank?
      redirect_to request.referer, notice: "検索キーワードを入力してください。"
    else
      @posts = Post.where('body LIKE ?', "%#{@content}%").order(created_at: :desc).page(params[:page])
      @grouped_posts = @posts.group_by { |post| post.created_at.to_date }
    end
  end
end
  

end
