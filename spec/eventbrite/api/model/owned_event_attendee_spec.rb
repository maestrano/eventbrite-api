require 'spec_helper'

describe Eventbrite::Api::Model::OwnedEventAttendee do

  let(:consumer) { {key: 'key', secret: 'secret'} }
  let(:params) { {consumer: consumer, access_token: 'access_token'} }

  subject { Eventbrite::Api::Client.new(params) }
  
  describe ".owned_event_attendees.get" do 
    let(:owned_event_attendees_response) { File.read('spec/fixtures/users/133925426255/owned_event_attendees.json') }

    before { stub_request(:get, "https://www.eventbriteapi.com/v3/users/133925426255/owned_event_attendees").to_return(:status => 200, :body => owned_event_attendees_response, :headers => {}) }
    
    it "fetches the list of owned event attendees" do
      expect(subject.owned_event_attendee.get({'user_id'=>'133925426255'})).to eql(JSON.parse(owned_event_attendees_response))
    end
  end

  describe ".owned_event_attendees.all" do 
    before { stub_request(:get, "https://www.eventbriteapi.com/v3/users/133925426255/owned_event_attendees")
              .to_return({:status => 200, :body => File.read('spec/fixtures/owned_event_attendees/page1.json'), :headers => {}}) }
    before { stub_request(:get, "https://www.eventbriteapi.com/v3/users/133925426255/owned_event_attendees?page=2")
              .to_return({:status => 200, :body => File.read('spec/fixtures/owned_event_attendees/page2.json'), :headers => {}}) }
    before { stub_request(:get, "https://www.eventbriteapi.com/v3/users/133925426255/owned_event_attendees?page=3")
              .to_return({:status => 200, :body => File.read('spec/fixtures/owned_event_attendees/page3.json'), :headers => {}}) }

    it "fetches the list of owned event attendees" do
      expect(subject.owned_event_attendee.all({'user_id'=>'133925426255'})['attendees'].count).to eql(139)
    end
  end
end
