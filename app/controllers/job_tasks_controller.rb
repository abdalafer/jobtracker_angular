class JobTasksController < ApplicationController
  before_action :require_login, except: [:index]

  def job_tasks
    @job = Job.where(uuid: params[:uuid]).first
    @customer = @job.customer
    breadcrumbs.add "Back to #{@customer.full_name} Jobs", "/customer/#{@customer.uuid}/jobs", id: "", class: "btn btn-primary"

    @tasks = @job.all_tasks if @job.present?
  end

  def add_job_task
    Rails.logger.info "add_job_task::params(#{params.inspect})"

    @job = Job.where(uuid: params[:job_task][:job_uuid]).first

    Rails.logger.info "add_job_task::job(#{@job.inspect})"
    if @job.present?
      @job.job_tasks.create(job_task_params)
      @tasks = @job.all_tasks
    end

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
  end

  def delete_job_task
    @job = Job.where(uuid: params[:job_uuid]).first

    job_task = JobTask.where(uuid: params[:task_uuid]).destroy_all

    @tasks = @job.all_tasks

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
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

    @job = Job.where(uuid: params[:job_uuid]).first
    @tasks = @job.all_tasks

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
  end

  def finish_job_task
    task = JobTask.where(uuid: params[:task_uuid]).first
    task.update(state: 'finished')

    @job = Job.where(uuid: params[:job_uuid]).first
    @tasks = @job.all_tasks

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
  end

  def job_task_details
    @job_task = JobTask.where(uuid: params[:uuid]).first
    @job = @job_task.job

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
  end

  def job_task_params
    params.require(:job_task).permit(:title, :notes, :state)
  end
end
