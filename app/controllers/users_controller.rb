class UsersController < ApplicationController
  skip_before_action :require_sign_in, only: [:new, :create]
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if (@user.save)
      flash[:success] = "You have successfully registered!"
      sign_in @user
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
