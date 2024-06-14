class Authentication::UsersController < Authentication::ApplicationController
  def edit
    @user = Authentication::User.find(params[:id])
  end

  def update
    @user = Authentication::User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to authentication_user_path(@user.id), status: :ok
    else
      flash[:alert] = "User not updated"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:authentication_user).permit(:password, :password_confirmation)
  end
end
