class ApplicationController < ActionController::Base

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !current_user
      flash[:login_alert] = "You must be logged in to do that."
      session[:return_to] = request.path
      redirect_to login_path
    end
  end
end
