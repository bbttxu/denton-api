# haileys_spec.rb

require 'spec_helper'

VCR.use_cassette 'haileys/http_request' do
  describe Haileys do |variable|
    describe "call api" do
      it "pulls info from the website" do
        response = Haileys.site()
        response.status[0].should == "200";
       end
    end

    describe "shows" do
      before(:all) do
        @shows = Haileys.shows()
      end

      it "finds upcoming shows" do
        @shows.count.should_not == 0
      end

      it "parses the source" do
        source = Haileys.parseSource @shows[0]
        source.length.should_not == 0
      end

      it "parses the price" do
        price = Haileys.parsePrice @shows[0]
        price.length.should_not == 0
      end
    end
  end
end
