class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :status
      t.timestamp :finished_at
      t.references :user, index: true, foreign_key: true
      t.belongs_to :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
