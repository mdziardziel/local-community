class Authentication::ApplicationController < ::ApplicationController
  layout "application"
  helper_method :current_user

  private

  def require_login
    return if current_user

    flash[:alert] = "You must be logged in to access this section"
    redirect_to new_authentication_user_session_path
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = session[:user_uuid] && Authentication::User.find_by(uuid: session[:user_uuid])
  end
end
