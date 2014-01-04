require 'spec_helper'

describe Gig do

  it "should be valid" do
    gig = FactoryGirl.create 'gig'
    gig.should be_valid
  end

  it "should have a show"
  it "should have an artist"
end
