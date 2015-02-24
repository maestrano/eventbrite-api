require 'base64'
require 'oauth2'

module Eventbrite
  module Api
    class Client
      include Eventbrite::Api::Helpers

      attr_reader :client, :access_token

      def initialize(options)
        model :User
        model :Venue
        model :Organizer
        model :Order
        model :Event
        model :Category
        model :Format
        model :EventTicketClass
        model :UserOrder
        model :UserVenue
        model :UserOrganizer
        model :OwnedEvent
        model :OwnedEventAttendee
        model :OwnedEventOrder

        @redirect_uri         = options[:redirect_uri]
        @consumer             = options[:consumer]
        @access_token         = options[:access_token]
        
        @client               = OAuth2::Client.new(@consumer[:key], @consumer[:secret], {
          :site          => 'https://www.eventbrite.com',
          :authorize_url => '/oauth/authorize',
          :token_url     => '/oauth/token',
        })
      end

      def get_access_code_url(params = {})
        @client.auth_code.authorize_url(params.merge(redirect_uri: @redirect_uri))
      end

      def get_access_token(access_code)
        @token         = @client.auth_code.get_token(access_code, redirect_uri: @redirect_uri)
        @access_token  = @token.token
        @token
      end

      def headers
        {
          'Accept'            => 'application/json',
          'Content-Type'      => 'application/json'
        }
      end

      def connection
        @auth_connection ||= OAuth2::AccessToken.new(@client, @access_token)
      end

    end
  end
end
