require 'rails_helper'

RSpec.describe "GroupMemberships", type: :request do
  fixtures :groups, :users, :group_memberships
  before(:each) do
    @michael = users(:michael)
    @archer = users(:archer)
    @example_group = groups(:example_group)
    @another_group = groups(:another_group)
    @membership = group_memberships(:membership_1)
  end

  it "should destroy group memberships when logged in" do
    log_in_as(@michael)
    expect{
        delete group_membership_path(@membership)
    }.to change {GroupMembership.count}.by(-1)
    expect(response).to redirect_to groups_path
  end

  it 'should remove member from the group when logged in' do
    log_in_as(@michael)
    expect {
      delete remove_member_from_group_path(@example_group, user_id: @archer.id)
    }.to change {GroupMembership.count}.by(-1)
    expect(response).to redirect_to group_members_path(@example_group)
  end
end
