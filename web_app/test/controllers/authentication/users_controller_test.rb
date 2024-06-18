require 'test_helper'

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = authentication_users(:one)
    @update_params = {
      authentication_user: {
        current_password: 'MyString',
        new_password: 'NewPassword',
        new_password_confirmation: 'NewPassword'
      }
    }
  end

  test "should get show when logged in" do
    login_as(@user)
    get authentication_user_url
    assert_response :success
    assert_select "span", "MyString"
  end

  test "shouldn't get show when not logged in" do
    get authentication_user_url
    assert_redirected_to new_authentication_user_session_path
  end

  test "should get edit when logged in" do
    login_as(@user)
    get authentication_user_edit_url
    assert_response :success
    assert_select "form"
  end

  test "shouldn't get edit when not logged in" do
    get authentication_user_edit_url
    assert_redirected_to new_authentication_user_session_path
  end

  test "should update user with valid params" do
    login_as(@user)
    patch authentication_user_url, params: @update_params
    assert_redirected_to authentication_user_path
    assert_equal "User updated successfully", flash[:notice]
    assert @user.reload.authenticate(@update_params.dig(:authentication_user, :new_password))
  end

  test "shouldn't update user with valid params when not logged in" do
    patch authentication_user_url, params: @update_params
    assert_redirected_to new_authentication_user_session_path
  end

  test "should not update user with invalid params" do
    login_as(@user)
    @update_params[:authentication_user][:new_password_confirmation] = 'Mismatch'
    patch authentication_user_url, params: @update_params
    assert_response :unprocessable_entity
    assert_equal "User not updated", flash[:alert]
  end

  private

  def login_as(user)
    post authentication_user_sessions_url, params: { authentication_user: { email: user.email, password: 'MyString' } }
  end
end
