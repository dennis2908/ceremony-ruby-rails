class PrayersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @prayers = Prayer.all_public
  end

  def show
    set_prayer
    authorize @prayer
    @comment = Comment.new(:prayer_id => params[:id])
  end

  def new
    @prayer = Prayer.new
  end

  def create
    @prayer = Prayer.new(prayer_params)
    @prayer.author = current_user
    
    if @prayer.save
      flash[:notice] = "Successfully shared a prayer"
      redirect_to prayers_path
    else
      flash[:alert] = @prayer.errors.full_messages.to_sentence
      redirect_to new_prayer_path
    end
  end

  def edit
    set_prayer
    authorize @prayer, :author?
  end

  def update
    set_prayer
    authorize @prayer, :author?
    @prayer.groups.each{|group| group.prayers.delete(@prayer)}
    if @prayer.update(prayer_params)
      flash[:notice] = "Successfully updated a prayer"
      redirect_to prayer_path(@prayer)
    else
      flash[:alert] = @prayer.errors.full_messages.to_sentence
      redirect_to edit_prayer_path
    end
  end

  def destroy
    set_prayer
    @prayer.destroy
    authorize @prayer, :author?
		flash[:notice] = "Prayer was deleted"
		redirect_to prayers_path
  end

  ######################

  # def next
    # need to receive id of prayer from which next/previous prayer button is clicked
    # raise params[:prayer_id].inspect
  #   @prayer = Prayer.find(params[:prayer_id])
  #   render json: @prayer.next_public_prayer
  # end





  private

  def prayer_params
    params.require("prayer").permit(:overview, :details, :is_anonymous, :is_public, group_ids:[])
  end

  def set_prayer
    @prayer = Prayer.find(params[:id])
  end
end
