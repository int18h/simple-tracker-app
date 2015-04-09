class AddUniqueIndexForNameToProjects < ActiveRecord::Migration
  def change
    add_index :projects, :name, unique: true
  end
  def down
    drop_index :projects, :name
  end
end
