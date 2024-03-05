class GroupsController < ApplicationController

  def index
    # @groups = Group.all
    @joined = current_user.groups
    @notJoined = Group.where.not(id: @joined.pluck(:id))
  end
  def show
    @group = Group.find(params[:id])
  end
end
