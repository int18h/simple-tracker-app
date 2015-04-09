class AddStatusToProject < ActiveRecord::Migration
  def change
    add_column :projects, :status, :integer, default: 1
  end
  def down
    drop_column :projects, :status
  end
end
