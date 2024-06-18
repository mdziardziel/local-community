require 'test_helper'

class Authentication::UserTest < ActiveSupport::TestCase
  setup do
    @user = authentication_users(:one)
    @community = authentication_communities(:one)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should not be valid without email" do
    @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "should not be valid with duplicate email" do
    duplicate_user = Authentication::User.new(email: @user.email, password: 'password', community: @community)
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "should not be valid without password" do
    @user.password = nil
    assert_not @user.valid?
    assert_includes @user.errors[:password], "can't be blank"
  end

  test "should belong to a community" do
    assert_respond_to @user, :community
    assert_equal @community, @user.community
  end

  test "should authenticate with correct password" do
    assert @user.authenticate('MyString')
  end

  test "should not authenticate with incorrect password" do
    assert_not @user.authenticate('wrongpassword')
  end
end
