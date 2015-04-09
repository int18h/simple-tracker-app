class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  before_action :set_issues_by_project, only: [:index]
  before_action :set_issue_by_project, only: [:new, :create]
  # GET /issues
  # GET /issues.json
  def index
    puts YAML::dump(params)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  def new
      #@issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    #@issue = Issue.create(issue_params)
    respond_to do |format|
      if @issue.update_attributes(issue_params)
        @issue.owner = User.find(issue_params[:user_id])
        format.html { redirect_to @project, notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @project, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end

  def search_issue
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
      @project = Project.find(params[:project_id])
      #redirect_to @project, alert: 'You cannot update issue for closed project.' if @issue.
    end

    def set_issue_by_project
      @project = Project.find(params[:project_id])
      redirect_to @project, alert: 'You cannot create issue for closed project.' if (@project.closed?)
      @issue = Issue.find_by(project_id: params[:project_id], user_id: current_user.id)
      begin
        @issue = Issue.new   
        @issue.owner = current_user
        @issue.project = @project
      end if @issue.nil?
    end

    def set_issues_by_project
      @issues = Issue.all.find_by(project_id: params[:project_id], user_id: current_user.id)
      @issues = [] if @issues.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:name, :description, :user_id, :project_id, :estimated_hours)
    end
end
