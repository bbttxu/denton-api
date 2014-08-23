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
end
