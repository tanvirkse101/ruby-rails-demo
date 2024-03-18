require 'rails_helper'

RSpec.describe Micropost, type: :model do
  fixtures :users, :microposts
  before(:all) do
    # @user = users(:michael)
    # @micropost = @user.microposts.build(content: 'Lorem ipsum dolor sit amet')

  end

  it "should be valid" do
    micropost = microposts(:orange)
    expect(micropost).to be_valid
  end
end
