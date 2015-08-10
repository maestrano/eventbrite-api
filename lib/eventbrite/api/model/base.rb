module Eventbrite
  module Api
    module Model
      class Base

        def initialize(client, model_name=nil)
          @client          = client
          @model_name      = model_name || 'Base'
          
          @pagination = nil
          @endpoint = nil
        end

        def model_route
          @model_name.to_s.downcase
        end

        def get(opts={}, endpoint=nil)
          @endpoint = endpoint
          perform_request(url(opts, endpoint))
        end

        def find(id)
          self.get({}, id)
        end

        def create(object, opts={})
          @client.connection.post(url(opts), {:headers => @client.headers, :body => object.to_json})
        end

        def update(id, object, opts={})
          @client.connection.post(url(opts, id), {:headers => @client.headers, :body => object.to_json})
        end

        def all(opts)
          all_pages = get(opts)
          while @pagination && @pagination['page_number'] < @pagination['page_count']
            all_pages = all_pages.deep_merge(next_page(opts))
          end
          all_pages
        end

        def next_page(opts={})
          opts['params'] = {'page'=>@pagination['page_number']+1}
          get(opts, @endpoint)
        end

        def previous_page(opts={})
          opts['params'] = {'page'=>@pagination['page_number']-1}
          get(opts, @endpoint)
        end

protected
        def url(opts={}, endpoint=nil)
          if model_route == ''
            target = "https://www.eventbriteapi.com/v3"
          elsif endpoint
            target = "#{resource_url(opts)}/#{endpoint}"
          else
            target = resource_url(opts)
          end
          if opts['params']
            params = opts['params'].map { |k,v| "#{k}=#{v}" }.join('&')
            target = "#{target}?#{params}"
          end
          target
        end
        
        def resource_url(opts={})
          target = "https://www.eventbriteapi.com/v3/#{model_route}"
          opts.each { |k,v| target.gsub!(":#{k}", v) if v.is_a?(String) } unless opts.empty?
          target
        end
        
        def perform_request(target)
          response = @client.connection.get(target, {:headers => @client.headers})
          hash = JSON.parse(response.body)
          @pagination = hash['pagination']
          hash
        end
      end
    end
  end
end
