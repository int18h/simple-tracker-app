class SessionsController < ApplicationController
  skip_before_action :require_sign_in, only: [:new, :create]
  helper_method :redirect_to
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      sign_in @user
      flash[:success] = "Welcome, #{@user.full_name}"
      redirect_to dashboard_path
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
