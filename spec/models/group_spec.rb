require 'rails_helper'

RSpec.describe Group, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # fixtures :users

  before(:each) do
    @group = create(:group, name: "Example", description: "Example", creator: create(:tanaka))
  end

  it "should be valid" do
    expect(@group).to be_valid
  end

  it "name should be present" do
    @group.name = "     "
    expect(@group).not_to be_valid
  end

  it "name should not be too long" do
    @group.name = "a" * 51
    expect(@group).not_to be_valid
  end

  it "description should be present" do
    @group.description = "     "
    expect(@group).not_to be_valid
  end

  it "description should not be too long" do
    @group.description = "a" * 256
    expect(@group).not_to be_valid
  end

  it "creator should be present" do
    @group.creator = nil
    expect(@group).not_to be_valid
  end

  it "should have group memberships" do
    expect(@group).to respond_to(:group_memberships)
  end

  it "should have members" do
    expect(@group).to respond_to(:members)
  end

  it "should have chats" do
    expect(@group).to respond_to(:chats)
  end

end
