class Public::MessagesController < ApplicationController
  def new
  end

  def index
  end

  def create
    message = current_user.sent_messages.new(post_message_params)
    message.sender_id = current_user.id
    if message.save
      redirect_to request.referer, notice: 'エールを送りました。優しさをありがとう！あなたの明日もより良い1日になりますように💫'
    else
      # モデルのバリデーションエラーをフラッシュメッセージに含める↓
      flash[:alert] = message.errors.full_messages.join(', ')
      redirect_to request.referer
    end
  end


  def destroy
    message = Message.find(params[:id])
    
    if message.sender_id == current_user.id
      message.destroy
      redirect_to request.referer, notice: 'メッセージを削除しました'
    else
      redirect_to request.referer, alert: 'メッセージを削除する権限がありません'
    end
  end
  
  private

  def post_message_params
    params.require(:message).permit(:body, :receiver_id, :message_text_id)
  end
  
end
