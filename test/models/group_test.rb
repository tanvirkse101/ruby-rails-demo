require "test_helper"

class GroupTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael) 
    @group = Group.new(name: "Example Group", description: "This is an example group", creator: @user)
  end

  test "should be valid" do
    assert @group.valid?
  end

  test "name should be present" do
    @group.name = "     "
    assert_not @group.valid?
  end

  test "name should not be too long" do
    @group.name = "a" * 51
    assert_not @group.valid?
  end

  test "description should be present" do
    @group.description = "     "
    assert_not @group.valid?
  end

  test "description should not be too long" do
    @group.description = "a" * 256
    assert_not @group.valid?
  end

  test "creator should be present" do
    @group.creator = nil
    assert_not @group.valid?
  end

  test "should have group memberships" do
    assert_respond_to @group, :group_memberships
  end

  test "should have members" do
    assert_respond_to @group, :members
  end

  test "should have chats" do
    assert_respond_to @group, :chats
  end
end
