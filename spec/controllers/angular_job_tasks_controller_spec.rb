require 'rails_helper'

RSpec.describe AngularJobTasksController, type: :controller do
  describe "customer job tasks" do
    it "creates a task" do
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      #create job
      customer = FactoryGirl.create(:customer, {user_id: user.id})
      job = FactoryGirl.create(:job, {uuid: SecureRandom.uuid, customer_id: customer.id})

      post :add_job_task, job_task: {job_uuid: job.uuid, title: 'Car', notes: 'first task here'}
    end
  end
end