require 'spec_helper'

describe Eventbrite::Api::Model::OwnedEventOrder do

  let(:consumer) { {key: 'key', secret: 'secret'} }
  let(:params) { {consumer: consumer, access_token: 'access_token'} }

  subject { Eventbrite::Api::Client.new(params) }
  
  describe ".owned_event_order.get" do 
    let(:owned_event_orders_response) { File.read('spec/fixtures/users/133925426255/owned_event_orders.json') }

    before { stub_request(:get, "https://www.eventbriteapi.com/v3/users/133925426255/owned_event_orders").to_return(:status => 200, :body => owned_event_orders_response, :headers => {}) }
    
    it "fetches the list of owned event orders" do
      expect(subject.owned_event_order.get({'user_id'=>'133925426255'})).to eql(JSON.parse(owned_event_orders_response))
    end
  end
end
