require 'spec_helper'

describe Eventbrite::Api::Model::OwnedEvent do

  let(:consumer) { {key: 'key', secret: 'secret'} }
  let(:params) { {consumer: consumer, access_token: 'access_token'} }

  subject { Eventbrite::Api::Client.new(params) }
  
  describe ".owned_event.get" do 
    let(:owned_events_response) { File.read('spec/fixtures/users/133925426255/owned_events.json') }

    before { stub_request(:get, "https://www.eventbriteapi.com/v3/users/133925426255/owned_events").to_return(:status => 200, :body => owned_events_response, :headers => {}) }
    
    it "fetches the list of owned events" do
      expect(subject.owned_event.get({'user_id'=>'133925426255'})).to eql(JSON.parse(owned_events_response))
    end
  end
end
