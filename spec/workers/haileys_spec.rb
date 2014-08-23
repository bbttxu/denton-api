# haileys_spec.rb

require 'spec_helper'

describe Haileys do |variable|
  describe "call api" do
    it "pulls info from the website" do
      VCR.use_cassette 'haileys/http_request' do
        response = Haileys.site()
        response.status[0].should == "200";
       end
    end
  end
end
