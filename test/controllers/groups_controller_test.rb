require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @michael = users(:michael)
    @group = groups(:example_group)
  end

  # インデックスが必要
  test "should get index" do
    log_in_as(@michael)
    get groups_url
    assert_response :success
  end

  # グループを表示する
  test "should show group" do
    log_in_as(@michael)
    get group_url(@group)
    assert_response :success
  end

  # 新しい
  test "should get new" do
    log_in_as(@michael)
    get new_group_url
    assert_response :success
  end

  # グループを作成する必要がある
  test "should create group" do
    log_in_as(@michael)
    assert_difference('Group.count') do
      post groups_url, params: { group: { name: "New Group", description: "Description" } }
    end

    assert_redirected_to group_url(Group.last)
  end

  # 更新
  test "should get edit" do
    log_in_as(@michael)
    get edit_group_url(@group)
    assert_response :success
  end

  # test "should update group" do
  #   log_in_as(@michael)
  #   patch group_url(@group), params: { group: { name: "Updated Group" } }
  #   assert_redirected_to group_path(@group), "Expected to be redirected to group URL"
  #   follow_redirect!
  #   assert_response :success
  #   assert_select 'div.alert-info', /Group successfully updated!/
  #   @group.reload
  #   assert_equal "Updated Group", @group.name
  # end

  # グループを解除する必要がある
  test "should destroy group" do
    log_in_as(@michael)
    assert_difference('Group.count', -1) do
      delete group_url(@group)
    end
    assert_redirected_to groups_url
  end
end
