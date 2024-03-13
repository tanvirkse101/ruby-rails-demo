class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  # マイクロポストの下に新しいコメントを作成する
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to root_url, flash: { success: 'Comment created!' }
    else
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end
  # コメントを削除する
  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    if request.referrer.nil? || request.referrer == micropost_comment_url
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :image)
  end

  def correct_user
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find_by(id: params[:id])

    if @comment.nil? || @comment.user != current_user
      redirect_to root_url, status: :see_other
    end
  end
end
