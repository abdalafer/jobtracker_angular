class AngularJobTasksController < ApplicationController
  before_action :require_login, except: [:index]

  def job_tasks
    job = Job.where(uuid: params[:uuid]).first
    #@customer = @job.customer

    tasks = job.all_tasks if job.present?

    api_response ({job: job, tasks: tasks}).to_json
  end

  def add_job_task
    job = Job.where(uuid: params[:job_task][:job_uuid]).first

    if job.present?
      job.job_tasks.create(job_task_params)
      tasks = job.all_tasks
    end

    api_response ({job: job, tasks: tasks}).to_json
  end

  def delete_job_task
    JobTask.where(uuid: params[:task_uuid]).destroy_all

    api_response
  end

  def update_job_task
    task = JobTask.where(uuid: params[:task_uuid]).first
    task.update(job_task_params)

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
  end

  def start_job_task
    task = JobTask.where(uuid: params[:task_uuid]).first
    task.update(state: 'started')

    api_response
  end

  def finish_job_task
    task = JobTask.where(uuid: params[:task_uuid]).first
    task.update(state: 'finished') if task.present?

    api_response
  end

  def job_task_details
    job_task = JobTask.where(uuid: params[:uuid]).first
    job = @job_task.try(:job)

    api_response ({job: job, task: job_task}).to_json
  end

  def job_task_params
    params.require(:job_task).permit(:title, :notes, :state)
  end
end
