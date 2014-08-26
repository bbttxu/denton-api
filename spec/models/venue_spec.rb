require 'spec_helper'

VCR.use_cassette 'venue/geocode' do
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

    it "should have a phone number" do
      venue = FactoryGirl.build 'venue', phone: ""
      venue.should_not be_valid
    end

    it "should have an address" do
      venue = FactoryGirl.build 'venue', address: ""
      venue.should_not be_valid
    end

    it "should have a slug" do
      venue = FactoryGirl.build 'venue', slug: ""
      venue.should_not be_valid
    end

    it "should have a location" do
      venue = FactoryGirl.build 'venue', address: "Denton, TX"
      venue.save
      venue.coordinates.should be_present
    end
  end
end
