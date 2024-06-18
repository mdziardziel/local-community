require 'test_helper'

class Authentication::UserSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = authentication_users(:one)
    @community = authentication_communities(:one)
  end

  test "should get new" do
    get new_authentication_user_session_url
    assert_response :success
    assert_select "form"
  end

  test "should create session with valid credentials" do
    post authentication_user_sessions_url, params: { authentication_user: { email: @user.email, password: 'MyString' } }
    assert_redirected_to authentication_user_path
    assert_equal @user.uuid, session[:user_uuid]
    assert_equal @community.uuid, session[:community_uuid]
  end

  test "should not create session with invalid credentials" do
    post authentication_user_sessions_url, params: { authentication_user: { email: @user.email, password: 'wrongpassword' } }
    assert_redirected_to new_authentication_user_session_path
    assert_nil session[:user_uuid]
    assert_nil session[:community_uuid]
    assert_equal "Login failed", flash[:alert]
  end

  test "should destroy session" do
    post authentication_user_sessions_url, params: { authentication_user: { email: @user.email, password: 'MyString' } }
    delete authentication_user_sessions_url
    assert_redirected_to new_authentication_user_session_path
    assert_nil session[:user_uuid]
    assert_nil session[:community_uuid]
  end
end
