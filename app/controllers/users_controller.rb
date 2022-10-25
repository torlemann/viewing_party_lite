class UsersController < ApplicationController

  before_action :get_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_dashboard_path
    else
      @errors = @user.errors
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
      session[:user_id] = user.id
      redirect_to user_dashboard_path
    else
      @error = true
      render :login_form
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end