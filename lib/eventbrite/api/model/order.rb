module Eventbrite
  module Api
    module Model
      class Order < Base
      	def model_route
          'users/:user_id/orders'
        end
      end
    end
  end
end
