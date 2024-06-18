class Authentication::UsersController < Authentication::ApplicationController
  before_action :require_login

  def show
    @user = Authentication::User.find(current_user.id)
  end

  def edit
    @user_form = Authentication::UpdateUserForm.new(
      Authentication::User.find(current_user.id)
    )
  end

  def update
    @user_form = Authentication::UpdateUserForm.new(
      Authentication::User.find(current_user.id),
      user_params
    )

    if @user_form.submit
      flash[:notice] = "User updated successfully"
      redirect_to authentication_user_path
    else
      flash[:alert] = "User not updated"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:authentication_user)
      .permit(:current_password, :new_password, :new_password_confirmation)
  end
end
