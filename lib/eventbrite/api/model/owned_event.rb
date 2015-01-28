module Eventbrite
  module Api
    module Model
      class OwnedEvent < Base
      	def model_route
          'users/:user_id/owned_events'
        end
      end
    end
  end
end
