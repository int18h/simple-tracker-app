class CreateTeamsUsersRelationTable < ActiveRecord::Migration
  def change
    create_join_table :teams, :users do |t|
      t.index [:team_id, :user_id], unique: true
    end
  end
end
