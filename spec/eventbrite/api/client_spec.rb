require 'spec_helper'

describe Eventbrite::Api::Client do

  let(:consumer) { {key: 'key', secret: 'secret'} }
  let(:params) { {redirect_uri: 'redirect_uri', consumer: consumer, access_token: 'access_token'} }

  subject { Eventbrite::Api::Client.new(params) }

  describe ".get_access_code_url" do 
    it "generates the access code url" do
      expect(subject.get_access_code_url).to eql('https://www.eventbrite.com/oauth/authorize?client_id=key&redirect_uri=redirect_uri&response_type=code')
    end
  end

  describe ".get_access_token" do 
    let(:access_code) { '123' }

    before { Timecop.freeze(Time.parse("2015-01-01T00:00:00")) }
    after { Timecop.return }

    it "requests the access_token" do
      stub_request(:post, "https://www.eventbrite.com/oauth/token").
         to_return(:status => 200, :body => {'access_token'=>'access_code','token_type'=>'bearer'}.to_json, 
                                   :headers => {"content-type"=>"application/json; charset=utf-8"})

      subject.get_access_token(access_code)
      expect(subject.access_token).to eql('access_code')
    end
  end

  describe ".connection" do 
    let (:expires_in) { 1200 }
    
    before { stub_request(:post, "https://www.eventbrite.com/oauth/token").
              to_return(:status => 200, :body => {'access_token'=>'access_code','token_type'=>'bearer'}.to_json, 
                                        :headers => {"content-type"=>"application/json; charset=utf-8"}) }
    before { subject.get_access_token('access_code') }

    context "current token is valid" do
      it "returns the current access token" do
        expect(subject.connection).to be_a(OAuth2::AccessToken)
      end
    end
  end
end
