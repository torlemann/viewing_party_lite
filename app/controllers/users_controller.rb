class UsersController < ApplicationController

  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      session[:user_id] = @new_user.id
      flash[:notice] = "Welcome #{@new_user.name}!"
      redirect_to user_dashboard_path
    else
      @errors = @new_user.errors
      render :new
    end
  end

  def login_form
    @email = nil
  end

  def login
    @email = params[:email]
    user = User.find_by(email: @email)
    if user && user.authenticate(params[:password])
      flash[:notice] = "Welcome #{user.name}!"
      session[:user_id] = user.id
      redirect_to user_dashboard_path
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

end