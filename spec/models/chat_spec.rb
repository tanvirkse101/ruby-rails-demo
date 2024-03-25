require 'rails_helper'

RSpec.describe Chat, type: :model do
  fixtures :users, :chats, :groups
  before(:each) do
    @chat = Chat.new(user: users(:michael), group: groups(:example_group), text: 'testing')
  end

  it "should be valid" do
    expect(@chat).to be_valid
  end

  it "should have a user" do
    @chat.user = nil
    expect(@chat).to_not be_valid
  end

  it "should have text" do
    @chat.text = nil
    expect(@chat).to_not be_valid
  end

  it "text shouldn't be too long" do
    @chat.text = "a" * 256
    expect(@chat).not_to be_valid
  end

  it "should allow valid image types" do
    valid_image_types = %w[image/jpeg image/gif image/png]
    valid_image_types.each do |image_type|
      @chat.image.attach(io: File.open("test/fixtures/files/sample_image.jpg"), filename: "sample_image.jpg", content_type: image_type)
      expect(@chat).to be_valid, "#{image_type} should be a valid image type"
      @chat.image.purge
    end
  end

  it "image should be less than 5 megabytes" do
    @chat.image.attach(io: File.open("test/fixtures/files/large_image.jpg"), filename: "large_image.jpg", content_type: "image/jpeg")
    expect(@chat).not_to be_valid
    @chat.image.purge
  end

end
