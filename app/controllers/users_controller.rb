class UsersController < ApplicationController

  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      session[:user_id] = @new_user.id
      flash[:notice] = "Welcome #{@new_user.name}!"
      redirect_to cookies.delete(:return_to) || dashboard_path
    else
      @errors = @new_user.errors
      render :new
    end
  end

  def login_form
    @email = cookies[:email]
  end

  def login
    check_remember_me
    @email = params[:email]
    user = User.find_by(email: @email)
    if user && user.authenticate(params[:password])
      flash[:notice] = "Welcome #{user.name}!"
      session[:user_id] = user.id
      redirect_to cookies.delete(:return_to) || dashboard_path
    else
      @error = true
      render :login_form
    end
  end

  def logout
    session.clear
    flash[:notice] = "You have been successfully logged out."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_remember_me
    if params[:remember_me] == "1"
      cookies[:email] = { value: params[:email], expires: 90.days }
    elsif cookies[:email] == params[:email] && params[:remember_me] == "0"
      cookies.delete :email
    end
  end

end