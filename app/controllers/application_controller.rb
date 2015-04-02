class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :require_sign_in
  
  private
    def require_sign_in
      unless signed_in?
        flash[:danger] = "You must be signed in to access this section"
        redirect_to signin_path
      end
    end
    
end
