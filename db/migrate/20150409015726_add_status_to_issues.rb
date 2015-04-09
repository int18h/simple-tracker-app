class AddStatusToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :status, :integer, default: 1
  end
  def down
    drop_column :issues, :status
  end
end
