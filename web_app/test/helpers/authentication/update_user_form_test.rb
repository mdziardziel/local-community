require 'test_helper'

class Authentication::UpdateUserFormTest < ActiveSupport::TestCase
  setup do
    @user = authentication_users(:one)
  end

  test "should be valid with correct current password and matching new passwords" do
    form = Authentication::UpdateUserForm.new(@user, current_password: 'MyString', new_password: 'NewPassword', new_password_confirmation: 'NewPassword')
    assert form.valid?
  end

  test "should be invalid without current password" do
    form = Authentication::UpdateUserForm.new(@user, current_password: nil, new_password: 'NewPassword', new_password_confirmation: 'NewPassword')
    assert_not form.valid?
    assert_includes form.errors[:current_password], "can't be blank"
  end

  test "should be invalid without new password" do
    form = Authentication::UpdateUserForm.new(@user, current_password: 'MyString', new_password: nil, new_password_confirmation: 'NewPassword')
    assert_not form.valid?
    assert_includes form.errors[:new_password], "can't be blank"
  end

  test "should be invalid without new password confirmation" do
    form = Authentication::UpdateUserForm.new(@user, current_password: 'MyString', new_password: 'NewPassword', new_password_confirmation: nil)
    assert_not form.valid?
    assert_includes form.errors[:new_password_confirmation], "can't be blank"
  end

  test "should be invalid with incorrect current password" do
    form = Authentication::UpdateUserForm.new(@user, current_password: 'WrongPassword', new_password: 'NewPassword', new_password_confirmation: 'NewPassword')
    assert_not form.valid?
    assert_includes form.errors[:current_password], "is invalid"
  end

  test "should be invalid when new password and confirmation do not match" do
    form = Authentication::UpdateUserForm.new(@user, current_password: 'MyString', new_password: 'NewPassword', new_password_confirmation: 'DifferentPassword')
    assert_not form.valid?
    assert_includes form.errors[:new_password_confirmation], "is invalid"
  end

  test "should update user password with valid attributes" do
    form = Authentication::UpdateUserForm.new(@user, current_password: 'MyString', new_password: 'NewPassword', new_password_confirmation: 'NewPassword')
    assert form.submit
    assert @user.authenticate('NewPassword')
  end

  test "should not update user password with invalid attributes" do
    form = Authentication::UpdateUserForm.new(@user, current_password: 'WrongPassword', new_password: 'NewPassword', new_password_confirmation: 'NewPassword')
    assert_not form.submit
    assert_not @user.authenticate('NewPassword')
  end
end
