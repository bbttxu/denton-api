require 'spec_helper'

describe ShowsController, :type => :controller do
  describe "JSON interaction" do
    it "should return on index JSON" do
      request.accept = "application/json"
      get :index
      response.should be_success
    end
    it "should respond properly to a JSONP callback"
  end

  describe "JSON interaction" do
    it "should return calendar JSON" do
      request.accept = "application/json"
      get :calendar
      response.should be_success
    end
    it "should respond properly to a JSONP callback"
  end
end