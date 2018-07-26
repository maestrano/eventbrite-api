module Eventbrite
  module Api
    module Model
      class Attendee < Base
      	def model_route
          'events/:event_id/attendees'
        end
      end
    end
  end
end
