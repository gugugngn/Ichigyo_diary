class Admin::MessageTextController < ApplicationController
  def new
    @message_text = MessageText.new
    @message_texts = MessageText.all
  end
  
  def create
    @message_text = MessageText.new(message_text_params)
    if @message_text.save
      redirect_to request.referer, notice: '追加に成功しました。'
    else
      render :new, notice: '失敗しました。'
    end
  end
  
  def destroy
    message_text = MessageText.find(params[:id])
    message_text.destroy
    redirect_to request.referer
  end
  
  private
  
  def message_text_params
    params.require(:message_text).permit(:content)
  end
end
