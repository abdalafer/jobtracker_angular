Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root 'main#customers'
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
