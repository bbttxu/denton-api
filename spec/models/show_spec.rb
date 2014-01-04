require 'spec_helper'

describe Show do
  it "should be valid" do
    show = FactoryGirl.create 'show'
    show.should be_valid
  end

  describe "validations" do
    it "should have a price" do
      show = FactoryGirl.build 'show', price: ""
      show.should_not be_valid
    end

    it "should have a source" do
      show = FactoryGirl.build 'show', source: ""
      show.should_not be_valid
    end

    it "should indicate whether start time is uncertain" do
      show = FactoryGirl.build 'show', time_is_uncertain: ""
      show.should_not be_valid
    end

    it "should have a starts_at" do
      show = FactoryGirl.build 'show', starts_at: ""
      show.should_not be_valid
    end
  end

  # it "should have a unique name" do
  #   show = FactoryGirl.create 'show', name: 'Bad Leaf'
  #   copycat = FactoryGirl.build 'show', name: 'Bad Leaf'
  #   copycat.should_not be_valid
  # end
end
