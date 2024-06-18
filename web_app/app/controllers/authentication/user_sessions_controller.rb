class Authentication::UserSessionsController < Authentication::ApplicationController
  def new
    @user = Authentication::User.new
  end

  def create
    @user = Authentication::User.find_by(email: user_params[:email])

    if @user && @user.authenticate(user_params[:password])
      session[:user_uuid] = @user.uuid
      session[:community_uuid] = @user.community.uuid
      redirect_to authentication_user_path
    else
      flash[:alert] = "Login failed"
      redirect_to new_authentication_user_session_path
    end
  end

  def destroy
    session[:user_uuid] = nil
    session[:community_uuid] = nil
    redirect_to new_authentication_user_session_path
  end  

  private

  def user_params
    params.require(:authentication_user).permit(:email, :password)
  end
end
