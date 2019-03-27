class GroupsController < ApplicationController
  include GroupsHelper
  before_action :authenticate_user!

  def index
    @groups = Group.all_public
  end

  def show
    set_group
    @prayers = policy_scope(Prayer)
    @group_comment = GroupComment.new(:group_id => @group.id)
    authorize @group
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.leader = current_user
    @group.members << current_user
    
    if @group.save
      flash[:notice] = "Successfully started a new prayer group"
      redirect_to group_path(@group)
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      redirect_to new_group_path
    end
  end

  def edit
    set_group
    authorize @group, :leader?
  end

  def update
    set_group
    authorize @group, :leader?
    if @group.update(group_params)
      flash[:notice] = "Successfully updated prayer group"
      redirect_to group_path(@group)
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      redirect_to new_group_path
    end
  end 

  def destroy
    set_group
    authorize @group, :leader?
    @group.destroy
		flash[:notice] = "Group was deleted"
		redirect_to groups_path
  end

  def add_member
    set_group
    authorize @group, :leader?
    find_and_add_member
    redirect_to group_path(@group)
  end

  def join
    set_group
    authorize @group
    @group.members << current_user
    @group.save
    flash[:notice] = "You've joined the group!"
    redirect_to group_path(@group)
  end

  def leave
    set_group
    authorize @group
    @group.members.delete(current_user)
    @group.save
    flash[:notice] = "You've left #{@group.name}"
    redirect_to groups_path
  end 

  private

  def group_params
    params.require("group").permit(:name, :description, :is_public, members:[:name])
  end

  def new_member_params
    # raise params.require("group").require("members").inspect
    params.require("group").require("members").permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
