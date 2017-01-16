class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :full_name
      t.string :address
      t.text :notes

      t.timestamps null: false
    end
  end
end
