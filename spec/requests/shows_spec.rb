require 'spec_helper'

describe "Shows API" do
  # TODO these tests should probably done at controler level
  it 'sends a list of shows' do
    FactoryGirl.create_list( :show, 10 )

    get '/shows'

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)

    json['shows'].count().should equal(10) # check to make sure the right amount of messages are returned
  end

  # TODO these tests should probably done at controler level
  it 'should take and use a callback parameter' do
    FactoryGirl.create_list( :show, 10 )

    get '/shows', callback: 'callback'

    expect(response).to be_success            # test for the 200 status-code

    response.body.index('callback').should eq(0)
    # json['shows'].count().should equal(10) # check to make sure the right amount of messages are returned
  end

  it 'should include midnight dates properly' do
    FactoryGirl.create( :show, { starts_at: Chronic.parse( "2014-08-30" ).localtime.at_beginning_of_day()} )

    Show.all.by_day.should include('2014-08-30')
    Show.all.by_day.should_not include('2014-08-29')
  end
end
