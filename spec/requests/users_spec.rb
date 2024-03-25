require 'rails_helper'

RSpec.describe "Users", type: :request do
  fixtures :users

  before(:each) do
    @user = users(:michael)
    @other_user = users(:archer)
  end

  describe "GET /new" do
    it "should get the new user" do
      get signup_path
      expect(response).to be_successful
    end
  end

  describe "GET /index" do
    it "should redirect index when not logged in" do
      get users_path
      expect(response).to redirect_to(login_url)
    end
  end

  describe "Get /update" do
    it "should not allow the admin attribute to be edited via the web" do
      log_in_as(@other_user)
      expect(@other_user.admin?).to_not be_truthy

      patch user_path(@other_user), params: {
        user: {
          password: "password",
          password_confirmation: "password",
          admin: true
        }
      }

      @other_user.reload
      expect(@other_user.admin?).to_not be_truthy
    end
  end

  describe "GET /edit" do
    it "should redirect edit when not logged in" do
      get edit_user_path(@user)
      expect(response).to redirect_to(login_url)
      expect(flash).not_to be_empty
    end
  end

  describe "GET /update" do
    it "should redirect update when not logged in" do
      patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
      expect(response).to redirect_to(login_url)
      expect(flash).not_to be_empty
    end
  end

  describe "GET /edit" do
    it "should redirect edit when logged in as wrong user" do
      log_in_as(@other_user)
      get edit_user_path(@user)
      expect(flash).to be_empty
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET /update" do
    it "should redirect update when logged in as wrong user" do
      log_in_as(@other_user)
      patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
      expect(flash).to be_empty
      expect(response).to redirect_to(root_url)
    end
  end

  describe "DELETE /destroy" do
    it "should redirect delete when not logged in" do
      expect {
        delete user_path(@user)
    }.not_to change { User.count }
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(login_url)
    end
  end

  describe "DELETE /destroy" do
    it "should redirect destroy when logged in as a non-admin" do
      log_in_as(@other_user)
      expect {
        delete user_path(@user)
    }.not_to change { User.count }
    expect(response).to have_http_status(:see_other)
    expect(response).to redirect_to(root_url)
    end
  end

  describe "GET /following" do
    it "should redirect following when not logged in" do
      get following_user_path(@user)
      expect(response).to redirect_to(login_url)
    end
  end

  describe "GET /follower" do
    it "should redirect followers when not logged in" do
      get followers_user_path(@user)
      expect(response).to redirect_to(login_url)
    end
  end

end
