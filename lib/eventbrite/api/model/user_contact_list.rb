module Eventbrite
  module Api
    module Model
      class UserContactList < Base
        def model_route
          'users/:user_id/contact_lists'
        end
      end
    end
  end
end
