class Public::MessagesController < ApplicationController
  def new
  end

  def index
  end

  def create
    message = current_user.sent_messages.new(post_message_params)
    message.sender_id = current_user.id
    if message.save
      redirect_to request.referer, notice: 'エールを送りました。'
    else
      redirect_to request.referer, alert: 'エールの送信に失敗しました。'
    end
  end


  def destroy
  end
  
  private

  def post_message_params
    params.require(:message).permit(:body, :receiver_id, :message_text_id)
  end
  
end
