require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: { content: 'Lorem ipsum' } }
    end
    assert_redirected_to login_url
  end

  test 'should create comment when logged in' do
    log_in_as(@user)
    assert_difference 'Comment.count', 1 do
      post micropost_comments_path(@micropost), params: { comment: { content: 'Lorem ipsum' } }
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Comment.count' do
      delete micropost_comment_path(@micropost, @micropost.comments.first)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy for wrong comment' do
    log_in_as(@user)
    comment = comments(:one)
    assert_no_difference 'Comment.count' do
      delete micropost_comment_path(@micropost, comment)
    end
    assert_redirected_to root_url
  end

  test 'should destroy comment when logged in' do
    log_in_as(@user)
    comment = @micropost.comments.first
    assert_difference 'Comment.count', -1 do
      delete micropost_comment_path(@micropost, comment)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end
end
