module SessionsHelper
  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    # cookies.permanent[:remember_token] = {
    #   value: remember_token,
    #   expires: 1.hours
    # }
    
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    #puts YAML::dump(current_user)
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def show_sidebar_if(signed)
    "toggled" if (!signed)
  end

  def hidden_if(signed)
    "display: none" if (!signed)
  end

  def profile_link_to_current_user
    return "#{link_to current_user.full_name, user_path(current_user)}".html_safe if (self.signed_in?)
  end

  def profile_link_to_user(user)
    return "#{link_to user.full_name, user_path(user)}".html_safe
  end
end
