module Eventbrite
  module Api
    module Model
      class Base

        def initialize(client, model_name=nil)
          @client          = client
          @model_name      = model_name || 'Base'
          
          @links = nil
        end

        def model_route
          @model_name.to_s.downcase
        end

        def get(opts = nil)
          perform_request(url(opts))
        end

        def find(id)
          perform_request(url({'id'=>id}))
        end

        def save(object)
          new_record?(object) ? create(object) : update(object)
        end

protected
        def url(opts = nil)
          if model_route == ''
            "https://www.eventbriteapi.com/v3"
          elsif opts && opts['id']
            "#{resource_url(opts)}/#{opts['id']}"
          else
            resource_url(opts)
          end
        end

        def new_record?(object)
          object["id"].nil? || object["id"] == ""
        end

        def create(object)
          @client.connection.post(url, {:headers => @client.headers, :body => object.to_json})
        end

        def update(object)
          @client.connection.put(url(object), {:headers => @client.headers, :body => object.to_json})
        end

        def link(name)
          return nil unless @links
          link_hash = @links.select{|link_hash| link_hash['rel'] == name}.first
          link_hash ? link_hash['href'] : nil
        end
        
        def resource_url(opts={})
          url = "https://www.eventbriteapi.com/v3/#{model_route}"
          opts.each do |k,v|
            url = "https://www.eventbriteapi.com/v3/#{model_route}".gsub(":#{k}", v)
          end if opts
          url
        end
        
        def perform_request(url)
          response = @client.connection.get(url, {:headers => @client.headers})
          hash = JSON.parse(response.body)
          @links = hash['_links']
          hash
        end
      end
    end
  end
end
