require 'rails_helper'

RSpec.describe Relationship, type: :model do
  # fixtures :users

  before(:each) do
    @tanaka = create(:tanaka)
    @hiro = create(:hiro)
    @relationship = create(:relationship, follower: @tanaka, followed: @hiro)
  end

  it "should be valid" do
    expect(@relationship).to be_valid
  end

  it "should require a follower id" do
    @relationship.follower_id = nil
    expect(@relationship).to_not be_valid
  end

end
