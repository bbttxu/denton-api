require 'spec_helper'

describe Show do
  it "should be valid" do
    show = FactoryGirl.create 'show'
    show.should be_valid
  end

  # it "should have a name" do
  #   show = FactoryGirl.build 'show', name: ''
  #   show.should_not be_valid
  # end

  # it "should have a unique name" do
  #   show = FactoryGirl.create 'show', name: 'Bad Leaf'
  #   copycat = FactoryGirl.build 'show', name: 'Bad Leaf'
  #   copycat.should_not be_valid
  # end
end
