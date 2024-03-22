require 'rails_helper'

RSpec.describe Comment, type: :model do
  fixtures :users, :microposts

  before(:each) do
    @comment = Comment.new(
      user: users(:michael),
      micropost: microposts(:orange),
      content: "Test comment"
    )
  end

  it "should be valid" do
    expect(@comment).to be_valid
  end

  it "should require a user" do
    @comment.user = nil
    expect(@comment).to_not be_valid
  end

  it "should require a micropost" do
    @comment.micropost = nil
    expect(@comment).to_not be_valid
  end

  it "should have content" do
    @comment.content = " "
     expect(@comment).to_not be_valid
  end

 it "content shouldn't exceed max length" do
  @comment.content = "a" * 256
  expect(@comment).to_not be_valid
 end

  it "should allow valid image types" do
    valid_image_types = %w[image/jpeg image/gif image/png]
    valid_image_types.each do |image_type|
      @comment.image.attach(io: File.open("test/fixtures/files/sample_image.jpg"), filename: "sample_image.jpg", content_type: image_type)
      expect(@comment).to be_valid, "#{image_type} should be a valid image type"
      @comment.image.purge
    end
  end

  it "image should be less than 5 megabytes" do
    @comment.image.attach(io: File.open("test/fixtures/files/large_image.jpg"), filename: "large_image.jpg", content_type: "image/jpeg")
    expect(@comment).not_to be_valid
    @comment.image.purge
  end

end
