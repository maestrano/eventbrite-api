module Eventbrite
  module Api
    module Model
      class UserOrder < Base
      	def model_route
          'users/:user_id/orders'
        end
      end
    end
  end
end
