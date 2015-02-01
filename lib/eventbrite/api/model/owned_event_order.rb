module Eventbrite
  module Api
    module Model
      class OwnedEventOrder < Base
      	def model_route
          'users/:user_id/owned_event_orders'
        end
      end
    end
  end
end
