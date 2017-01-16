class AddUuidToTask < ActiveRecord::Migration
  def change
    add_column :job_tasks, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
