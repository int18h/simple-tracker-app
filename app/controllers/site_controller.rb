class SiteController < ApplicationController
  skip_before_action :require_sign_in, only: [:welcome]
  def welcome
    redirect_to dashboard_path if signed_in?
  end
  
  def dashboard
  end

  def log_time
    workload = Workload.create(workload_params)
    workload.user = current_user
    respond_to do |format|
      if workload.save
        format.html { redirect_to dashboard_path, notice: 'You successfully logged time' }
      else
        format.html { redirect_to dashboard_path, alert: 'It was not possible to fill up the time for the task.'}
      end
    end
  end

  def search_for_issue
    query = params[:q]
    @issues = Issue.all.where('name LIKE ? AND user_id = ? ', "%#{query}%", current_user.id)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { render json: @issues, only: [:id, :name] , :root => false}
    end
  end
  private
    def workload_params
      params.permit(:description, :issue_id, :hours)
    end
end
