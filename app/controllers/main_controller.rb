class MainController < ApplicationController
  before_action :require_login, except: [:index]

  def index
  end

  def customers
    @customers = current_user.customers
  end

  def add_customer
    customer = current_user.customers.create(customer_params)
    if customer.present?
      @customers = current_user.customers
    end

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
  end

  def update_customer
    @customer = current_user.customers.where(uuid: params[:uuid]).first
    @customer.update(customer_params)

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
  end

  def customer_jobs
    breadcrumbs.add "Back to Customers", "/", id: "bread_customer", class: "btn btn-primary"

    @customer = current_user.customers.where(uuid: params[:uuid]).first
    @jobs = @customer.jobs
  end

  def add_customer_job
    #get customer uuid
    #load it and create job for it
    #/customer/:uuid/add_job
    customer = current_user.customers.where(uuid: params[:job][:customer_uuid]).first

    if customer.present?
      customer.jobs.create(customer_job_params)
      @jobs = customer.jobs
    end

    respond_to do |format|
      format.html {render or redirect_to '/'}
      format.js
    end
  end

  def customer_params
    params.require(:customer).permit(:full_name, :address, :notes)
  end

  def customer_job_params
    params.require(:job).permit(:title, :notes)
  end

end
