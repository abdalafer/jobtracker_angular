class RenameTaskToJobTask < ActiveRecord::Migration
  def change
    rename_table :tasks, :job_tasks
  end
end
