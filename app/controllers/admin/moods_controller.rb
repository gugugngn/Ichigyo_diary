class Admin::MoodsController < ApplicationController
  
  def new
    @mood = Mood.new
    @moods = Mood.all
  end
  
  def create
    @mood = Mood.new(mood_params)
    if @mood.save
      redirect_to request.referer, notice: '追加に成功しました。'
    else
      render :new, notice: '失敗しました。'
    end
    
  end

  def destroy
    mood = Mood.find(params[:id])
    mood.destroy
    redirect_to request.referer
  end
  
  private
  
  def mood_params
    params.require(:mood).permit(:name, :color)
  end

end
