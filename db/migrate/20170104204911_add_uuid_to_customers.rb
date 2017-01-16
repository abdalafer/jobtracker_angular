class AddUuidToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
