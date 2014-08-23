# scraper_spec.rb

require 'spec_helper'

describe Scraper do
  before(:all) do
    @scraper = Scraper.new
  end

  describe "slug" do
    it "slugifies an name" do
      @scraper.slugify("Floating Action").should == "floating-action"
      @scraper.slugify("Floating & Action").should == "floating-and-action"
    end
  end
  describe "slugify" do
    it "slugifies an name" do
      "Floating Action".slugify.should == "floating-action"
      "Floating & Action".slugify.should == "floating-&-action"
    end
  end

  describe "deslugify" do
    it "deslugifies an name" do
      "floating-action".deslugify.should == "Floating Action"
      "floating-&-action".deslugify.should == "Floating & Action"
    end
  end
end
