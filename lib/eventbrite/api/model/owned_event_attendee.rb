module Eventbrite
  module Api
    module Model
      class OwnedEventAttendee < Base
      	def model_route
          'users/:user_id/owned_event_attendees'
        end
      end
    end
  end
end
