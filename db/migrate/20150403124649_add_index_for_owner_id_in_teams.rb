class AddIndexForOwnerIdInTeams < ActiveRecord::Migration
  def change
    add_index :teams, :owner_id
  end
end
