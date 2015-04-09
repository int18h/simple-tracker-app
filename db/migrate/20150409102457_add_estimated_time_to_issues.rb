class AddEstimatedTimeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :estimated_hours, :float, precision: 5, scale: 3
  end
  def down
    drop_column :issues, :estimated_hours
  end
end
