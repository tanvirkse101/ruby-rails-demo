require "test_helper"

class GroupMembershipTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @group = groups(:example_group)
    @group_membership = GroupMembership.new(user: @user, group: @group)
  end

  test "should be valid" do
    assert @group_membership.valid?
  end

  test "should require a user" do
    @group_membership.user = nil
    assert_not @group_membership.valid?
  end

  test "should require a group" do
    @group_membership.group = nil
    assert_not @group_membership.valid?
  end

  test "should validate uniqueness of user within a group" do
    duplicate_membership = @group_membership.dup
    @group_membership.save
    assert_not duplicate_membership.valid?
  end
end
