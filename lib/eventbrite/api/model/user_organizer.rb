module Eventbrite
  module Api
    module Model
      class UserOrganizer < Base
      	def model_route
          'users/:user_id/organizer'
        end
      end
    end
  end
end
