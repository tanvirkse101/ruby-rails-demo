require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  fixtures :microposts, :users
  before(:each) do
    @michael = users(:michael)
    @micropost = microposts(:orange)
  end

  it "should redirect create without login" do
    expect{
      post microposts_path, params: {
        micropost: { content: "Lorem ipsum" }
      }
    }.not_to change { Micropost.count }.from(Micropost.count)
    expect(response).to redirect_to login_url
  end

  it "should redirect delete without login" do
    expect{
      delete micropost_path(@micropost)
    }.not_to change { Micropost.count }
    expect(response).to have_http_status(:see_other)
    expect(response).to redirect_to login_url
  end

  it "should redirect for destroying wrong micropost" do
    log_in_as(@michael)
    micropost = microposts(:ants)
    expect{
      delete micropost_path(micropost)
    }.not_to change { Micropost.count }
    expect(response).to have_http_status(:see_other)
    expect(response).to redirect_to root_url
  end

end
