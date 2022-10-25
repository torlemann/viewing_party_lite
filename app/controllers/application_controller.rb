class ApplicationController < ActionController::Base
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def get_user
    if current_user
      @user = current_user
    else
      render file: "/public/404"
    end
  end
end
