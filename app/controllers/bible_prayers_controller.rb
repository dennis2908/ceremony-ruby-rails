class BiblePrayersController < ApplicationController

  def index
    @bible_prayers = BiblePrayer.all
  end

  def show
    @bible_prayer = BiblePrayer.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @bible_prayer }
    end
  end

  def new
    @bible_prayer = BiblePrayer.new
  end 

  def create
    bible_prayer = BiblePrayer.create(bible_prayer_params)
    redirect_to bible_prayer_path(bible_prayer)
  end

  def edit
    @bible_prayer = BiblePrayer.find(params[:id])
  end

  def update
    @bible_prayer = BiblePrayer.find(params[:id])
    @bible_prayer.update(bible_prayer_params)
    redirect_to bible_prayer_path(@bible_prayer)
  end

  private

  def bible_prayer_params
    params.require('bible_prayer').permit(:title, :verse, :summary, :scripture)
  end

end