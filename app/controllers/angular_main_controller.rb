class AngularMainController < ApplicationController
  before_action :require_login
  #before_action :non_auth_current_user

  def home
    render layout: 'angular_application'
  end

  def customers
    customers = current_user.customers
    api_response customers.to_json
  end

  def customer_jobs
    #todo error handling
    customer = current_user.customers.where(uuid: params[:uuid]).first
    jobs = customer.try(:jobs)

    api_response ({customer: customer, jobs: jobs}).to_json
  end

  def add_customer
    customer = current_user.customers.create(customer_params)

    api_response customer.to_json
  end

  def add_customer_job
    #get customer uuid
    #load it and create job for it
    #/customer/:uuid/add_job
    customer = current_user.customers.where(uuid: params[:job][:customer_uuid]).first

    if customer.present?
      customer.jobs.create(customer_job_params)
      #@jobs = customer.jobs
    end

    api_response
  end

  def customer_params
    params.require(:customer).permit(:full_name, :address, :notes)
  end

  def customer_job_params
    params.require(:job).permit(:title, :notes)
  end

end
