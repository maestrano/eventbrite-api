module Eventbrite
  module Api
    module Model
      class Venue < Base
      	def model_route
          'users/:user_id/venues'
        end
      end
    end
  end
end
