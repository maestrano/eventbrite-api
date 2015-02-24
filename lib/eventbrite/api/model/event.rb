module Eventbrite
  module Api
    module Model
      class Event < Base
      	def model_route
          'events'
        end

        def search(opts={})
          self.get(opts, 'search')
        end
      end
    end
  end
end
