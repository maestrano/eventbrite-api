require 'spec_helper'

describe Eventbrite::Api::Model::Base do

  let(:consumer) { {key: 'key', secret: 'secret'} }
  let(:params) { {redirect_uri: 'redirect_uri', consumer: consumer, access_token: 'access_token'} }
  let(:client) { Eventbrite::Api::Client.new(params) }

  subject { Eventbrite::Api::Model::Base.new(client, 'base') }

end
