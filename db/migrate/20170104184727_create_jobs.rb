class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :state, default: 0, null: false
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end