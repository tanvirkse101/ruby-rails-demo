class GroupsController < ApplicationController

  def index
    # @groups = Group.all
    @joined = current_user.groups
    @notJoined = Group.where.not(id: @joined.pluck(:id))
  end
  def show
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "Group successfully created!"
      redirect_to group_path(@group)
    else
      flash[:error] = "Group could not be created!"
      redirect_to groups_path
    end
  end

  def destroy
    @group.destroy
    flash[:success] = "Group successfully deleted!"
    if request.referrer.nil? || request.referrer == groups_path
      redirect_to group_path, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
