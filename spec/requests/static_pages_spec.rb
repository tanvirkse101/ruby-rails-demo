require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    it "returns http success and has correct title" do
      get root_path
      expect(response).to be_successful
      expect(response.body).to include("<title>Ruby on Rails Tutorial Sample App</title>")
    end
  end

  describe "GET /help" do
    it "returns http success and has correct title" do
      get help_path
      expect(response).to be_successful
      expect(response.body).to include("<title>Help | Ruby on Rails Tutorial Sample App</title>")
    end
  end

  describe "GET /about" do
    it "returns http success and has correct title" do
      get about_path
      expect(response).to be_successful
      expect(response.body).to include("<title>About | Ruby on Rails Tutorial Sample App</title>")
    end
  end

  describe "GET /contact" do
    it "returns http success and has correct title" do
      get contact_path
      expect(response).to be_successful
      expect(response.body).to include("<title>Contact | Ruby on Rails Tutorial Sample App</title>")
    end
  end
end
