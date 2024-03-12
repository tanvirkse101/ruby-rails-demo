# app/controllers/group_memberships_controller.rb
class GroupMembershipsController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    current_user.join(group)
    redirect_to group_path(group), notice: "Successfully joined the group #{group.name}"
  end

  def destroy
    group_membership = current_user.group_memberships.find(params[:id])
    group = group_membership.group
    group_membership.destroy
    redirect_to groups_path, notice: "Left the group #{group.name}"
  end

  def add_member
    group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    group_membership = GroupMembership.new(group: group, user: user)
    if group_membership.save
      redirect_to group_members_path(group), notice: "Added #{user.name} to the group"
    else
      redirect_to group_members_path(group), alert: "Failed to add #{user.name} to the group"
    end
  end

  def remove_member
    group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    group_membership = group.group_memberships.find_by(user: user)
    if group_membership
      group_membership.destroy
      redirect_to group_members_path(group), notice: "Removed #{user.name} from the group"
    else
      redirect_to group_members_path(group), alert: "#{user.name} is not a member of the group"
    end
  end

end
