module Eventbrite
  module Api
    module Model
      class UserContact < Base
        def model_route
          'users/:user_id/contact_lists/:contact_list_id/contacts'
        end
      end
    end
  end
end
