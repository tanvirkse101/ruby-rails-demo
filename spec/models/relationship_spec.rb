require 'rails_helper'

RSpec.describe Relationship, type: :model do
  fixtures :users

  before(:each) do
    @relationship = Relationship.new(follower_id: users(:michael).id,
    followed_id: users(:archer).id)
  end

  it "should be valid" do
    expect(@relationship).to be_valid
  end

  it "should require a follower id" do
    @relationship.follower_id = nil
    expect(@relationship).to_not be_valid
  end

end
