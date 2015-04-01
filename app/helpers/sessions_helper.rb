module SessionsHelper

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(session[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = {
      value: remember_token,
      expires: 1.minutes
    }
    
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(remember_token: User.encrypt(remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

end
