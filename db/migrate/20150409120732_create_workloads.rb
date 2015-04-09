class CreateWorkloads < ActiveRecord::Migration
  def change
    create_table :workloads do |t|
      t.string :description
      t.float :hours
      t.integer :issue_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
