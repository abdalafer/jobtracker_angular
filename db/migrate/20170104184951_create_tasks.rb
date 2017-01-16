class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :state
      t.integer :state, default: 0, null: false
      t.references :job, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
