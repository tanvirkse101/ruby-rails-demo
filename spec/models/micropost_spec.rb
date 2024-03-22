require 'rails_helper'

RSpec.describe Micropost, type: :model do
  fixtures :users, :microposts

  before(:each) do
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  it "should be valid" do
    expect(@micropost).to be_valid
  end

  it "user id should be present" do
    @micropost.user_id = nil
    expect(@micropost).to_not be_valid
  end

  it "content should be present" do
    @micropost.content = "  "
    expect(@micropost).to_not be_valid
  end

  it "content length should be less than 140 characters" do
    @micropost.content = "a" * 141
    expect(@micropost).to_not be_valid
  end

  it "order should be most recent first" do
    expect(microposts(:most_recent)).to eq(Micropost.first)
  end
end
