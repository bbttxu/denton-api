require 'spec_helper'

describe Gig do

  it "should be valid" do
    gig = FactoryGirl.create 'gig'
    gig.should be_valid
  end

  # it "should have a name" do
  #   gig = FactoryGirl.build 'gig', name: ''
  #   gig.should_not be_valid
  # end

  # it "should have a unique name" do
  #   gig = FactoryGirl.create 'gig', name: 'Bad Leaf'
  #   copycat = FactoryGirl.build 'gig', name: 'Bad Leaf'
  #   copycat.should_not be_valid
  # end
end
