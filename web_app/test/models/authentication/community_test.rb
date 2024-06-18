require 'test_helper'

class Authentication::CommunityTest < ActiveSupport::TestCase
  setup do
    @community = authentication_communities(:one)
    @user_one = authentication_users(:one)
    @user_two = authentication_users(:two)
  end

  test "should have many users" do
    assert_respond_to @community, :users
    assert_equal 1, @community.users.count
  end

  test "should return associated users" do
    assert_includes @community.users, @user_one
  end

  test "should allow adding users" do
    new_user = Authentication::User.create!(
      email: "newuser@example.com",
      password: "password",
      community: @community
    )
    assert_includes @community.users, new_user
    assert_equal 2, @community.users.count
  end

  test "should destroy associated users when community is destroyed" do
    community = authentication_communities(:two)
    user = authentication_users(:two)
    assert_difference('Authentication::User.count', -1) do
      community.destroy
    end
    assert_nil Authentication::User.find_by(id: user.id)
  end
end
