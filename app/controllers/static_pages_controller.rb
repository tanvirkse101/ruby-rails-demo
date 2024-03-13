class StaticPagesController < ApplicationController


  # 現在のユーザーのマイクロポストを含む（ふくむ）ホームページを表示する
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
