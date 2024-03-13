require 'test_helper'

class GroupMembershipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @michael = users(:michael)
    @archer = users(:archer)
    @example_group = groups(:example_group)
    @another_group = groups(:another_group)
    @membership = group_memberships(:membership_1)
  end

  # test 'should create group membership when logged in' do
  #   log_in_as(@michael)
  #   assert_difference '@michael.groups.count', 1 do
  #     post group_memberships_path(@example_group.id)
  #   end
  #   assert_redirected_to group_path(@example_group)
  #   follow_redirect!
  #   assert_select 'div.notice', /Successfully joined the group/
  # end

  # ログイン時にグループメンバーシップを解除する
  test 'should destroy group membership when logged in' do
    log_in_as(@michael)
    assert_difference '@michael.groups.count', -1 do
      delete group_membership_path(@membership)
    end
    assert_redirected_to groups_path
    follow_redirect!
    assert_select 'div.alert-info', /Left the group/
  end

  # test 'should add member to the group when logged in' do
  #   log_in_as(@michael)
  #   assert_difference '@example_group.members.count', 1 do
  #     post add_member_to_group_path(@example_group.id, user_id: @archer.id)
  #   end
  #   assert_redirected_to group_members_path(@example_group)
  #   follow_redirect!
  #   assert_select 'div.alert', /Added/
  # end

  # ログイン時にメンバーをグループから削除する。
  test 'should remove member from the group when logged in' do
    log_in_as(@michael)
    assert_difference '@example_group.members.count', -1 do
      delete remove_member_from_group_path(@example_group, user_id: @archer.id)
    end
    assert_redirected_to group_members_path(@example_group)
    follow_redirect!
    assert_select 'div.alert-info', /Removed/
  end
end
