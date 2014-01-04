require 'spec_helper'

describe Artist do
  it "should be valid" do
    artist = FactoryGirl.create 'artist'
    artist.should be_valid
  end

  it "should have a name" do
    artist = FactoryGirl.build 'artist', name: ''
    artist.should_not be_valid
  end

  it "should have a unique name" do
    artist = FactoryGirl.create 'artist', name: 'Bad Leaf'
    copycat = FactoryGirl.build 'artist', name: 'Bad Leaf'
    copycat.should_not be_valid
  end
end


