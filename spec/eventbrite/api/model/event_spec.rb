require 'spec_helper'

describe Eventbrite::Api::Model::Event do

  let(:consumer) { {key: 'key', secret: 'secret'} }
  let(:params) { {consumer: consumer, access_token: 'access_token'} }

  subject { Eventbrite::Api::Client.new(params) }
  
  describe ".event.search" do 
    let(:events_page1_response) { File.read('spec/fixtures/events_page1.json') }
    let(:events_page2_response) { File.read('spec/fixtures/events_page1.json') }
    let(:events_page3_response) { File.read('spec/fixtures/events_page1.json') }

    before { stub_request(:get, "https://www.eventbriteapi.com/v3/events/search").to_return(:status => 200, :body => events_page1_response, :headers => {}) }
    before { stub_request(:get, "https://www.eventbriteapi.com/v3/events/search?page=2").to_return(:status => 200, :body => events_page2_response, :headers => {}) }
    before { stub_request(:get, "https://www.eventbriteapi.com/v3/events/search?page=3").to_return(:status => 200, :body => events_page3_response, :headers => {}) }
    
    it "fetches the list of events" do
      expect(subject.event.search).to eql(JSON.parse(events_page1_response))
      expect(subject.event.next_page).to eql(JSON.parse(events_page2_response))
      expect(subject.event.next_page).to eql(JSON.parse(events_page3_response))
      expect(subject.event.previous_page).to eql(JSON.parse(events_page2_response))
    end
  end
end
