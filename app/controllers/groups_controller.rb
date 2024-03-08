class GroupsController < ApplicationController

  def index
    @joined = current_user.groups
    @notJoined = Group.where.not(id: @joined.pluck(:id))
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @creator = (current_user == @group.creator)
    @chats = Chat.where(group_id: @group.id)
    @is_member = check_membership(@group)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.creator = current_user
    if @group.save
      flash[:success] = "Group successfully created!"
      current_user.join(@group)
      redirect_to group_path(@group)
    else
      flash[:error] = "Group could not be created!"
      redirect_to groups_path
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = "Group successfully deleted!"
    redirect_to groups_path, status: :see_other
  end

  def members
    @group = Group.find(params[:id])
    @members = @group.members.paginate(page: params[:page], per_page: 10)
    @non_members = User.where.not(id: @group.members.pluck(:id)).paginate(page: params[:page], per_page: 10)
    render 'members'
  end

  def edit
    @group = Group.find(params[:id])
    render 'edit'
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(params.require(:group).permit(:name, :description))
      flash[:success] = "Group successfully updated!"
      redirect_to group_path(@group)
    else
      flash[:error] = "Group could not be updated!"
      render 'edit'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def check_membership(group)
    if current_user.groups.exists?(group.id)
      return true
    else
      return false
    end
  end

end
