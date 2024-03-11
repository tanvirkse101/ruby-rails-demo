require "test_helper"

class ChatTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @group = groups(:example_group)
    @chat = Chat.new(user: @user, group: @group, text: "Example text")
  end

  test "should be valid" do
    assert @chat.valid?
  end

  test "user id should be present" do
    @chat.user_id = nil
    assert_not @chat.valid?
  end

  test "text should be present" do
    @chat.text = "   "
    assert_not @chat.valid?
  end

  test "text should not be too long" do
    @chat.text = "a" * 256
    assert_not @chat.valid?
  end

  test "image content type should be valid" do
    valid_image_types = %w[image/jpeg image/gif image/png]
    valid_image_types.each do |image_type|
      @chat.image.attach(io: File.open("test/fixtures/files/example_image.jpg"), filename: "example_image.jpg", content_type: image_type)
      assert @chat.valid?
      @chat.image.purge
    end
  end

  test "image size should be within 5 megabytes" do
    @chat.image.attach(io: File.open("test/fixtures/files/sample_image.jpg"), filename: "sample_image.jpg", content_type: "image/jpeg")
    assert_not @chat.valid?
  end
end
