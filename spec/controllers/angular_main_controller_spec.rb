require 'rails_helper'

RSpec.describe AngularMainController, type: :controller do
  describe "GET customers" do
    it "fails to authorize" do
      user = FactoryGirl.create(:user)

      get :customers
      expect(response.status).to eq(302)
    end

    it "returns a 200 status" do
      user = FactoryGirl.create(:user)
      sign_in_as(user)

      get :customers
      expect(response.status).to eq(200)
    end

    it "returns a multiple customers" do
      user = FactoryGirl.create(:user)
      sign_in_as(user)

      user.customers.create(full_name: 'jimmy')
      user.customers.create(full_name: 'larry')

      get :customers

      response_hash.first['full_name'].should eq('jimmy')
      response_hash.last['full_name'].should eq('larry')
    end
  end

  describe "GET customer jobs" do
    it "returns customer jobs" do
      user = FactoryGirl.create(:user)
      sign_in_as(user)

      customer = user.customers.create(full_name: 'jimmy', uuid: SecureRandom.uuid)
      job = customer.jobs.create(title: 'Car Work')

      get :customer_jobs, uuid: customer.uuid

      response_hash['jobs'].first['title'].should eq('Car Work')
    end
  end

  describe "POST add_customer" do
    it "creates a customer" do
      user = FactoryGirl.create(:user)
      sign_in_as(user)

      post :add_customer, customer: {full_name: 'Linda Smith', address: '123 sw 45 st'}

      Customer.last.full_name.should eq('Linda Smith')
      Customer.last.address.should eq('123 sw 45 st')
    end
  end

end
