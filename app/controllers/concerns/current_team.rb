module CurrentTeam
  extend ActiveSupport::Concern
  def set_team
    @team = Team.find_by(session[:team_id]);
  rescue
    @team = Team.create
    @team.user_id = current_user.id
    session[:team_id] = @team.id
  end


  private :set_team
end
