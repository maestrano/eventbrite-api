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

        def publish(id)
          self.update("#{id}/publish", {}, {})
        end

        def unpublish(id)
          self.update("#{id}/unpublish", {}, {})
        end
      end
    end
  end
end
