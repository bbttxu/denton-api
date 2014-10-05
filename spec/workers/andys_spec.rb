# andys_spec.rb

require 'spec_helper'

VCR.use_cassette 'andys/http_request' do
  describe Andys do |variable|
    describe "call api" do
      it "pulls info from the website" do
        response = Andys.site()
        response.status[0].should == "200";
       end
    end

    describe "shows" do
      before(:all) do
        @shows = Andys.shows()
      end

      it "finds upcoming shows" do
        @shows.count.should_not == 0
      end

      it "parses the source" do
        source = Andys.parseSource @shows[0]
        source.length.should_not == 0
      end

      # it "parses the price" do
      #   price = Andys.parsePrice @shows[0]
      #   price.length.should_not == 0
      # end
    end
  end
end
