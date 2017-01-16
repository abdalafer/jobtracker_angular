class Job < ActiveRecord::Base
  belongs_to :customer
  has_many :job_tasks

  enum status: [:created, :started, :finished]

  def all_tasks
    job_tasks.group_by {|t|t.state}
  end
end
