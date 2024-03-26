require 'rails_helper'

RSpec.describe "Comments", type: :request do
  fixtures :users, :microposts
  before(:each) do
    @user = users(:michael)
    @micropost = microposts(:orange)
  end

  it "should redirect create when not logged in" do
    expect{
      post micropost_comments_path(@micropost), params: {
        comment: { content: 'Lorem ipsum' }
      }
    }.not_to change{Comment.count}
    expect(response).to redirect_to login_url
  end

  it "should create comment when logged in" do
    log_in_as(@user)
    expect{
      post micropost_comments_path(@micropost), params: {
        comment: { content: 'Lorem ipsum' }
      }
    }.to change{Comment.count}.by(1)
    expect(response).to redirect_to root_url
  end

  it "should redirect destroy when not logged in" do
    expect{
      delete micropost_comment_path(@micropost, @micropost.comments.first)
    }.not_to change{Comment.count}
    expect(response).to redirect_to login_url
  end

end
