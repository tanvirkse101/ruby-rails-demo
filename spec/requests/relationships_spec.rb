require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  fixtures :relationships
  it "create should require a logged in user" do
    expect {
      post relationships_path
    }.not_to change { Relationship.count }
    expect(response).to redirect_to login_url
  end

  it "delete should require a logged in user" do
    expect {
      delete relationship_path(relationships(:one))
  }.not_to change { Relationship.count }
  expect(response).to redirect_to login_url
  end
end
