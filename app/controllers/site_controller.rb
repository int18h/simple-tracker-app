class SiteController < ApplicationController
  skip_before_action :require_sign_in, only: [:welcome]
  def welcome
    redirect_to dashboard_path if signed_in?

  end
  
  def dashboard
  end
end
