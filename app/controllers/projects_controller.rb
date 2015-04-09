class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy ]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    #@project = current_user.projects.build(project_params)
    @project = Project.create(project_params)
    @project.owner = current_user
    respond_to do |format|
      if @project.save
        @project.team = current_user.in_teams.find(project_params[:team_id])
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        @project.team = current_user.in_teams.find(project_params[:team_id])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def goto_issue
    logger.debug params
    # @issue = Issue.find()
    respond_to do |format|
      format.html { redirect_to project_issue_path(project_id: params[:project_id], id: params[:issue_id])}
    end
  end

  def search_issue
    query = params[:q]
    @issues = Issue.all.where('name LIKE ? AND project_id = ?', "%#{query}%", params[:project_id])
    logger.debug @issues.to_a
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { render json: @issues, only: [:id, :name, :project_id], :root => false }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :team_id, :user_id, :status)
    end
end
