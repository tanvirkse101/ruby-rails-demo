# test/models/comment_test.rb
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:archer)
    @micropost = microposts(:ants) 
    @comment = Comment.new(
      user: @user,
      micropost: @micropost,
      content: "This is a test comment",
    )
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "should require a user" do
    @comment.user = nil
    assert_not @comment.valid?
  end

  test "should require a micropost" do
    @comment.micropost = nil
    assert_not @comment.valid?
  end

  test "should require content" do
    @comment.content = " "
    assert_not @comment.valid?
  end

  test "content should not exceed maximum length" do
    @comment.content = "a" * 256
    assert_not @comment.valid?
  end

  test "should allow valid image types" do
    valid_image_types = %w[image/jpeg image/gif image/png]
    valid_image_types.each do |image_type|
      @comment.image.attach(io: File.open("test/fixtures/files/sample_image.jpg"), filename: "sample_image.jpg", content_type: image_type)
      assert @comment.valid?, "#{image_type} should be a valid image type"
      @comment.image.purge
    end
  end

  test "should reject invalid image types" do
    invalid_image_types = %w[image/tiff application/pdf]
    invalid_image_types.each do |image_type|
      @comment.image.attach(io: File.open("test/fixtures/files/booking-1.pdf"), filename: "booking-1.pdf", content_type: image_type)
      assert_not @comment.valid?, "#{image_type} should be an invalid image type"
      @comment.image.purge
    end
  end

  test "image should be less than 5 megabytes" do
    @comment.image.attach(io: File.open("test/fixtures/files/large_image.jpg"), filename: "large_image.jpg", content_type: "image/jpeg")
    assert_not @comment.valid?
    @comment.image.purge
  end
end
