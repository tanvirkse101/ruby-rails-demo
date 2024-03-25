require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  # ログインしていないときに編集をリダイレクトする
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # ログインしていないときの更新をリダイレクトする
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: {name: @user.name, email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # 間違ったユーザーでログインした場合、編集をリダイレクトする必要があります。
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  # 間違ったユーザーでログインした場合、更新をリダイレクトする必要がある
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  # ログインしていないときにインデックスをリダイレクトする
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  # 管理者属性はウェブ経由で編集できないようにすべきである
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?

    # ウェブから管理者属性を更新してみる
    patch user_path(@other_user), params: {
      user: {
        password:              "password",
        password_confirmation: "password",
        admin: true
      }
    }

    # Reload user from database to make sure the admin attribute didn't change
    @other_user.reload
    assert_not @other_user.admin?
  end

  # 非ログイン時にリダイレクト解除する必要がある。
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  # 非管理者としてログインしたときに解除する必要があります。
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end

  # ログインしていないときは、次のようにリダイレクトする
  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  # ログインしていないフォロワーをリダイレクトする
  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end

end
