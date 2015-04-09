class WorkloadsController < ApplicationController
  before_action :set_workload, only: [:show, :edit, :update, :destroy]
  before_action :set_workload_by_issue, only: [:new, :create]
  before_action :set_workloads_by_issue, only: [:index]

  # GET /workloads
  # GET /workloads.json
  def index
    @workloads = Workload.all
  end

  # GET /workloads/1
  # GET /workloads/1.json
  def show
  end

  # GET /workloads/new
  def new

  end

  # GET /workloads/1/edit
  def edit
  end

  # POST /workloads
  # POST /workloads.json
  def create
    respond_to do |format|
      if @workload.update_attributes(workload_params)
        @workload.user = @workload.issue.project.team.users.find(workload_params[:user_id])
        format.html { redirect_to [@workload.issue.project, @workload.issue], notice: 'Workload was successfully created.' }
        format.json { render json: @workload, status: :created}
      else
        format.html { render :new }
        format.json { render json: @workload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workloads/1
  # PATCH/PUT /workloads/1.json
  def update
    respond_to do |format|
      if @workload.update(workload_params)
        #@workload.issue = Issue.find(params[:issue_id])
        logger.debug @workload.issue
        format.html { redirect_to [@workload.issue.project, @workload.issue], notice: 'Workload was successfully updated.' }
        format.json { render json: @workload, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @workload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workloads/1
  # DELETE /workloads/1.json
  def destroy
    @workload.destroy
    respond_to do |format|
      format.html { redirect_to project_issue_workload_path, notice: 'Workload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workload
      @workload = Workload.find(params[:id])
      @issue = Issue.find(params[:issue_id])
      redirect_to @workload.issue, alert: 'You cannot set offline time for issue in closed project' if @workload.issue.project.closed?
    end

    def set_workload_by_issue
      @issue = Issue.find(params[:issue_id])
      redirect_to @issue, alert: 'You cannot add time for issue in closed project' if @issue.project.closed?
      begin
        @workload = Workload.new
        @workload.user = current_user
        @workload.issue = @issue
      end if @workload.nil?
    end

    def set_workloads_by_issue
      @workloads = Workload.all.find_by(issue_id: params[:issue_id], user_id: params[:user_id])
      @workloads = [] if @workloads.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workload_params
      params.require(:workload).permit(:description, :hours, :issue_id, :user_id)
    end
end
