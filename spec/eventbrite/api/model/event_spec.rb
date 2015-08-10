require 'spec_helper'

describe Eventbrite::Api::Model::Event do

  let(:consumer) { {key: 'key', secret: 'secret'} }
  let(:params) { {consumer: consumer, access_token: 'access_token'} }

  subject { Eventbrite::Api::Client.new(params) }
  
  describe ".event.search" do 
    let(:events_page1_response) { File.read('spec/fixtures/events_page1.json') }
    let(:events_page2_response) { File.read('spec/fixtures/events_page2.json') }
    let(:events_page3_response) { File.read('spec/fixtures/events_page3.json') }

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

  describe ".event.publish" do 
    let(:event_response) { File.read('spec/fixtures/events/13270934723/publish.json') }
    before { stub_request(:post, "https://www.eventbriteapi.com/v3/events/13270934723/publish").to_return(:status => 200, :body => event_response, :headers => {}) }
    
    let(:response) { subject.event.publish('13270934723') }
    
    it "publishes the event" do
      expect(response.status).to eql(200)
      expect(response.body).to eql(event_response)
    end
  end

  describe ".event.unpublish" do 
    let(:event_response) { File.read('spec/fixtures/events/13270934723/unpublish.json') }
    before { stub_request(:post, "https://www.eventbriteapi.com/v3/events/13270934723/unpublish").to_return(:status => 200, :body => event_response, :headers => {}) }

    let(:response) { subject.event.unpublish('13270934723') }
    
    it "publishes the event" do
      expect(response.status).to eql(200)
      expect(response.body).to eql(event_response)
    end
  end
end
