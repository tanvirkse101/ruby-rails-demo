class ChatsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  # 新しいチャットを作成する
  def create
    @group = Group.find(params[:group_id])
    @chat = @group.chats.build(chat_params)
    @chat.user = current_user

    if @chat.save
      redirect_to group_path(@chat.group), flash: { success: 'Chat was successfully created.' }
    else
      redirect_to group_path(@group), flash: { error: 'Chat could not be created!' }
    end
  end

  #チャット削除
  def destroy
    @chat.destroy
    redirect_to group_path(@chat.group), flash: { success: 'Chat was successfully deleted.' }
  end

  private

  # チャットのグループを設定する
  def set_group
    @group = Group.find(params[:group_id])
  end

  def chat_params
    params.require(:chat).permit(:text, :image)
  end
 # チャットの正しいユーザーを確認する
  def correct_user
    @group = Group.find(params[:group_id])
    @chat = @group.chats.find_by(id: params[:id])

    if @chat.nil? || @chat.user != current_user
      redirect_to root_url, status: :see_other
    end
  end
end
