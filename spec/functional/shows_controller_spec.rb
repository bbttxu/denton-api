require 'spec_helper'

describe ShowsController, :type => :controller do
  describe "an index" do
    it "should return JSON" do
      request.accept = "application/json"
      get :index
      response.should be_success
    end

    it "should respond properly to a JSONP callback"
  end

  describe "a calendar" do
    it "should return JSON" do
      request.accept = "application/json"
      get :calendar
      response.should be_success
    end

    it "should respond properly to a JSONP callback"

  end

  describe "a given day" do
    it "should return that days JSON" do
      request.accept = "application/json"
      get :day, date: "2014-12-14"
      response.should be_success
    end

    it "should respond properly to a JSONP callback"
  end
end