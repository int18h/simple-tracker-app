class WorkersController < ApplicationController
  skip_before_action :require_sign_in
  before_action :set_team, only: [:create]
  before_action :set_worker, only: [:show, :edit, :update, :destroy]

  def index
    @workers = Worker.all
  end

  def set_worker
    worker = Worker.find(:params[:id])
  end

  def worker_params
    params.require(:worker).permit(:team_id, :user_id)
  end

  private :set_worker, :worker_params
end
