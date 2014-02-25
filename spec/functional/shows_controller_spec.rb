require 'spec_helper'

describe ShowsController do
  describe "JSON interaction" do
    it "should return JSON" do
      request.accept = "application/json"
      get :index
      response.should be_success
    end
    it "should respond properly to a JSONP callback"
  end
end