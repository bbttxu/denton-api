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

  describe "searching" do
    it "should sort by day, one show on two days each" do
      show1 = FactoryGirl.create 'show', starts_at: "2014-07-01 23:59:59 -0500"
      show2 = FactoryGirl.create 'show', starts_at: "2014-07-02 00:00:01 -0500"

      Show.all.by_day.count.should be(2)
    end

    it "should sort by day, two shows on one day" do
      show1 = FactoryGirl.create 'show', starts_at: "2014-07-01 23:59:59 -0500"
      show2 = FactoryGirl.create 'show', starts_at: "2014-07-01 00:00:01 -0500"

      Show.all.by_day.count.should be(1)
    end
  end

  # it "should have a unique name" do
  #   show = FactoryGirl.create 'show', name: 'Bad Leaf'
  #   copycat = FactoryGirl.build 'show', name: 'Bad Leaf'
  #   copycat.should_not be_valid
  # end
end
