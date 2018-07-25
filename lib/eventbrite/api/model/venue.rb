module Eventbrite
  module Api
    module Model
      class Venue < Base
      	def model_route
          'organizations/:organization_id/venues'
        end
      end
    end
  end
end
