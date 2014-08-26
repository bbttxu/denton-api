# venues_controller_spec.rb

require 'spec_helper'

describe VenuesController, :type => :controller do
  describe "an index" do
    it "should return JSON" do
      request.accept = "application/json"
      get :index
      response.should be_success
    end

    # it "should respond properly to a JSONP callback"
  end

  describe "shows a venue" do
    before(:all) do
      FactoryGirl.create 'venue', { slug: :name}
    end

    it "should return that days JSON" do
      request.accept = "application/json"
      get :show, id: "name"
      response.should be_success
    end

    it "should respond properly to a JSONP callback"
  end
end
