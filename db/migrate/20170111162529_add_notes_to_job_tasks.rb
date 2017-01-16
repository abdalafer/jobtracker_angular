class AddNotesToJobTasks < ActiveRecord::Migration
  def change
    add_column :job_tasks, :notes, :text
  end
end
