class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.references :user, index: true, foreign_key: true
      t.belongs_to :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
