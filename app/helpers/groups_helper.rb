module GroupsHelper

  def find_and_add_member
    if !!find_by_username || !!find_by_email
			@new_member = find_by_username if !!find_by_username
      @new_member = find_by_email if !!find_by_email
      if @group.members.include?(@new_member)
        flash[:alert] = "#{new_member_params[:name]} is already part of the group"
      else
        @group.members << @new_member
        flash[:notice] = "Added #{@new_member.username} to the group!"
      end
    else
      flash[:alert] = "Unable to find #{new_member_params[:name]}"
    end

    
  end

  private

  def find_by_email
    User.find_by(:email => new_member_params[:name])
  end

  def find_by_username
    User.find_by(:username => new_member_params[:name])
  end
  
end
