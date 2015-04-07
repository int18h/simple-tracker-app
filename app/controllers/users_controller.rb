class UsersController < ApplicationController
  skip_before_action :require_sign_in, only: [:new, :create, :forgot_password]
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

  def edit
    @user = User.find(params[:id])
    if (@user.id != current_user.id)
      redirect_to dashboard_path
    end
  end

  def update
    if current_user.update_attributes(user_params)
      flash.now[:success] = "Profile updated."
      redirect_to dashboard_path
    else
      flash.now[:danger] = "Could not update your profile."
      render 'edit'
    end
    #puts YAML::dump(current_user)
  end

  def forgot_password
    @user = User.find_by_email(params[:email])
    if (!@user.nil?) 
      UserMailer.forgot_password_email(@user).deliver_later
      redirect_to signin_path

    else
      render "forgot_password"
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
