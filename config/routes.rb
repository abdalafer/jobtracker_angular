Rails.application.routes.draw do



  get '/' => 'angular_main#home'

  get 'a_customers_data' => 'angular_main#customers'
  get 'a_customer_data/:uuid/jobs' => 'angular_main#customer_jobs'
  get 'a_job/:uuid/tasks' => 'angular_job_tasks#job_tasks'
  post 'a_add_job_task' => 'angular_job_tasks#add_job_task'
  post 'a_add_customer' => 'angular_main#add_customer'
  post 'add_customer_job' => 'angular_main#add_customer_job'
  #put 'a_customer/:uuid/update' => 'main#update_customer'


  get 'customers' => 'main#customers'
  post 'add_customer' => 'main#add_customer'
  put 'customer/:uuid/update' => 'main#update_customer'

  get 'customer/:uuid/jobs' => 'main#customer_jobs'
  post 'add_customer_job' => 'main#add_customer_job'

  get 'job/:uuid/tasks' => 'job_tasks#job_tasks'
  post 'add_job_task' => 'job_tasks#add_job_task'
  put 'task/:task_uuid/update' => 'job_tasks#update_job_task'
  post 'job/:job_uuid/task/:task_uuid/start' => 'job_tasks#start_job_task'
  post 'job/:job_uuid/task/:task_uuid/finish' => 'job_tasks#finish_job_task'
  get 'task/:uuid' => 'job_tasks#job_task_details'
  delete 'job/:job_uuid/task/:task_uuid' => 'job_tasks#delete_job_task'

end
