require 'spec_helper'

describe Venue do
  it "should be valid" do
    venue = FactoryGirl.create 'venue'
    venue.should be_valid
  end

  it "should have a name" do
    venue = FactoryGirl.build 'venue', name: ''
    venue.should_not be_valid
  end

  it "should have a unique name" do
    artist = FactoryGirl.create 'venue', name: 'Bad Leaf'
    copycat = FactoryGirl.build 'venue', name: 'Bad Leaf'
    copycat.should_not be_valid
  end

  it "should have a phone number"
  it "should have an address"
end
