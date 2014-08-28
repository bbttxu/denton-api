# artists_controller_spec.rb

require 'spec_helper'

describe ArtistsController, :type => :controller do
  describe "an index" do
    it "should return JSON" do
      request.accept = "application/json"
      get :index
      response.should be_success
    end

    it "should respond properly to a JSONP callback"
  end



  describe "a given artust" do
    before(:all) do
      FactoryGirl.create 'artist', {:name => 'artist name', :slug => 'artist_name '}
    end

    it "should return that days JSON" do
      request.accept = "application/json"
      get :show, id: "artist_name"
      response.should be_success
    end

    it "should respond properly to a JSONP callback"
  end
end
