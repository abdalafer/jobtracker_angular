class JobTask < ActiveRecord::Base
  belongs_to :job

  enum state: [:created, :started, :finished]
end
