class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :add_member, :remove_member, :search_member]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = current_user.teams.build(team_params)
    puts YAML::dump(@team)
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    @team.user_id = current_user.id if @team.user_id.nil?
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_member
    Rails.logger.debug params.inspect
    @member = User.find(params[:user_id])
    @team.users << @member
    respond_to do |format|
      format.html { redirect_to @team, notice: 'New teammate Member was successfully added.' }
      format.js
    end
  end

  def remove_member
    @member = User.find(params[:user_id])
    @team.users.delete(@member)
    respond_to do |format|
      format.html { redirect_to @team, notice: 'Member was successfully removed.' }
      format.js
    end
  end

  def search_member
    query = params[:q]
    #@members = User.all.where('last_name LIKE ? AND id NOT IN (?)', "%#{query}%", @team.users.pluck(:id))
    @members = User.all.where('last_name LIKE ?', "%#{query}%")
    respond_to do |format|
      format.html { redirect_to @team }
      format.json { render json: @members, only: [:id, :full_name], :methods => :full_name }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
