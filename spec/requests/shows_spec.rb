require 'spec_helper'

describe "Shows API" do
  it 'sends a list of shows' do
    FactoryGirl.create_list( :show, 10 )

    get '/shows'

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)

    puts json

    json['shows'].count().should be_eq(10) # check to make sure the right amount of messages are returned
  end
end