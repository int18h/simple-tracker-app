class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.integer :project_id

      t.timestamps null: false
    end
  end
  def down
    drop_table :issues
  end
end
