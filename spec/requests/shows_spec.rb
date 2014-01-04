require 'spec_helper'

describe "Shows API" do
  it 'sends a list of shows' do
    FactoryGirl.create_list( :show, 10 )

    get '/shows'

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)

    json['shows'].count().should equal(10) # check to make sure the right amount of messages are returned
  end

  it 'should take and use a callback parameter' do
    FactoryGirl.create_list( :show, 10 )

    get '/shows', callback: 'callback'

    expect(response).to be_success            # test for the 200 status-code

    response.body.index('callback').should eq(0)
    # json['shows'].count().should equal(10) # check to make sure the right amount of messages are returned
  end
end