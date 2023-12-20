require "test_helper"

class CommentsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
    log_in_as(@user)
  end

  test "should comment on a micropost" do
    get root_path
    assert_template 'static_pages/home'

    assert_difference 'Comment.count', 1 do
      post micropost_comments_path(@micropost), params: { comment: { content: "This is a comment" } }
    end

    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.empty?
  end

  test "should not comment with invalid content" do
    get root_path
    assert_template 'static_pages/home'

    assert_no_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: { content: "" } }
    end

    assert_template 'static_pages/home'
    assert_select 'div#error_explanation'
  end

  test "should delete own comment" do
    comment = comments(:two)

    get root_path
    assert_template 'static_pages/home'

    assert_difference 'Comment.count', -1 do
      delete micropost_comment_path(@micropost, comment)
    end

    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
  end

  test "should not delete other user's comment" do
    comment = comments(:one)

    get root_path
    assert_template 'static_pages/home'

    assert_no_difference 'Comment.count' do
      delete micropost_comment_path(@micropost, comment)
    end

    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
  end
end
