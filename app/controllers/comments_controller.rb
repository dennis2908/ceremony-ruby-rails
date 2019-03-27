class CommentsController < ApplicationController 
  before_action :authenticate_user!

  def index
    set_prayer
    authorize @prayer, :show_comments?
    @comments = @prayer.all_comments
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @comments }
    end

  end

  def create
    set_prayer
    @comment = Comment.new(comment_params)
    @comment.commenter = current_user
    if @comment.save
      flash[:notice] = "Successfully posted a comment"
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_to prayer_path(@prayer)
  end

  def edit
    set_prayer
    set_comment
  end 

  def update
    set_prayer
    set_comment
    
    if @comment.update(comment_params)
      flash[:notice] = "Successfully posted a prayer"
      redirect_to prayer_path(@prayer)
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
      redirect_to prayer_comment_path(@prayer,@comment)
    end
  end 

  def destroy
    set_prayer
    set_comment
    @comment.destroy
    flash[:notice] = "Comment was deleted"
		redirect_to prayer_path(@prayer)
  end 

  private

  def comment_params
    params.require("comment").permit(:prayer_id, :content)
  end

  def set_prayer
    @prayer = Prayer.find(params[:prayer_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end