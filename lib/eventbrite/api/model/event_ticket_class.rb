module Eventbrite
  module Api
    module Model
      class EventTicketClass < Base
      	def model_route
          'events/:event_id/ticket_classes'
        end
      end
    end
  end
end
