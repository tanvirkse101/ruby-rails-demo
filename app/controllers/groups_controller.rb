class GroupsController < ApplicationController

  # 全グループのリストを表示する
  def index
    @joined = current_user.groups
    @notJoined = Group.where.not(id: @joined.pluck(:id))
    @group = Group.new
  end

  # 特定のグループを表示する
  def show
    @group = Group.find(params[:id])
    @creator = (current_user == @group.creator)
    @chats = Chat.where(group_id: @group.id)
    @is_member = check_membership(@group)
  end

  # 新しいグループ・フォームを表示する
  def new
    @group = Group.new
  end

  # 新しいグループ・フォームを送信（そうしん）する
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

  # グループの削除（さくじょ）する
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = "Group successfully deleted!"
    redirect_to groups_path, status: :see_other
  end

   # グループの全メンバーを表示（ひょうじ）する
  def members
    @group = Group.find(params[:id])
    @creator = (current_user == @group.creator)

    # Retrieve all members and non-members initially
    all_members = @group.members
    all_non_members = User.where.not(id: @group.members.pluck(:id))

    # Apply search query if present
    if params[:search].present?
      search_term = params[:search].downcase
      @members = all_members.where("LOWER(name) LIKE ?", "%#{search_term}%").paginate(page: params[:members_page], per_page: 5)
      @non_members = all_non_members.where("LOWER(name) LIKE ?", "%#{search_term}%").paginate(page: params[:nonmembers_page], per_page: 5)
    else
      @members = all_members.paginate(page: params[:members_page], per_page: 5)
      @non_members = all_non_members.paginate(page: params[:nonmembers_page], per_page: 5)
    end

    render 'members'
  end

  # グループ更新フォーム
  def edit
    @group = Group.find(params[:id])
    render 'edit'
  end

  # グループを更新する
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

  # 現在（げんざい）のユーザーがグループのメンバーかどうかをチェックする
  def check_membership(group)
    if current_user.groups.exists?(group.id)
      return true
    else
      return false
    end
  end

end
