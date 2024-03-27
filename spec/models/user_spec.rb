require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # fixtures :users

  before do
    @user = FactoryBot.build(:user,
    name: "Example User",
    email: "user@example.com",
    password: "foobar",
    password_confirmation: "foobar"
  )
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  it "should not be valid without a name" do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it "should not be valid without an email" do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it "should not be valid with a long name" do
    @user.name = "a" * 51
    expect(@user).to_not be_valid
  end

  it "should not be valid with a long email" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).to_not be_valid
  end

  it "should be valid without for only valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "should not be valid with an invalid email address" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "should not be valid if the email is not unique" do
    duplicate_user = @user.dup
    @user.save
    expect(duplicate_user).to_not be_valid
  end

  it "should not be valid without a password" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).to_not be_valid
  end

  it "should have minimum password length of 6" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user).to_not be_valid
  end

  it "authenticated? should return false for a user with nil digest" do
    expect(@user.authenticated?(:remember, "")).to be_falsey
  end

  it "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    expect { @user.destroy }.to change(Micropost, :count).by(-1)
  end

  it "should follow and unfollow a user" do
    tanaka = create(:tanaka)
    hiro = create(:hiro)
    expect(tanaka.following?(hiro)).to be_falsey
    tanaka.follow(hiro)
    expect(tanaka.following?(hiro)).to be_truthy
    expect(hiro.followers.include?(tanaka)).to be_truthy
    tanaka.unfollow(hiro)
    expect(tanaka.following?(hiro)).to be_falsey
    tanaka.follow(tanaka)
    expect(tanaka.following?(tanaka)).to be_falsey
  end

end
