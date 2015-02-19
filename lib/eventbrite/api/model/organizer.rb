module Eventbrite
  module Api
    module Model
      class Organizer < Base
      	def model_route
          'users/:user_id/organizers'
        end
      end
    end
  end
end
