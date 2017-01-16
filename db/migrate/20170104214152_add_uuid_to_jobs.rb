class AddUuidToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
