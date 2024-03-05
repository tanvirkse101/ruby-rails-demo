# app/controllers/group_memberships_controller.rb
class GroupMembershipsController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    current_user.join(group)
    redirect_to group_path(group), notice: "You have joined the group #{group.name}"
  end

  def destroy
    group_membership = current_user.group_memberships.find(params[:id])
    group = group_membership.group
    group_membership.destroy
    redirect_to group_path(group), notice: "You have left the group #{group.name}"
  end
end
