require 'rails_helper'

RSpec.describe "Groups", type: :request do
  fixtures :users, :groups
  before(:each) do
    @michael = users(:michael)
    @group = groups(:example_group)
  end

  it "shoud get index" do
    log_in_as(@michael)
    get groups_url
    expect(response).to be_successful
  end

  it "should show group" do
    login_url(@michael)
    get group_url(@group)
    expect(response).to be_successful
  end

  it "should get new group" do
    log_in_as(@michael)
    get new_group_url
    expect(response).to be_successful
  end

  it "should create new group" do
    log_in_as(@michael)
    expect{
      post groups_url, params: { group: {
        name: "New Group",
        description: "New Group Description"
        }
      }
    }.to change{Group.count}.by(1)
    expect(response).to redirect_to(group_url(Group.last))
  end

  it "should get edit group" do
    log_in_as(@michael)
    get edit_group_url(@group)
    expect(response).to be_successful
  end

  it "should destroy group" do
    log_in_as(@michael)
    expect{
      delete group_url(@group)
    }.to change{Group.count}.by(-1)
    expect(response).to redirect_to(groups_url)
  end

end
