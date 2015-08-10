class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

class ::Hash
  def deep_merge(second)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : Array === v1 && Array === v2 ? v1 | v2 : [:undefined, nil, :nil].include?(v2) ? v1 : v2 }
    self.merge(second.to_h, &merger)
  end
end

module Eventbrite
  module Api
    module Helpers
      def model(model_name)
        method_name = model_name.to_s.underscore
        variable_name = "@#{method_name}_model".to_sym
        unless instance_variable_defined?(variable_name)
          instance_variable_set(variable_name, Eventbrite::Api::Model.const_get("#{model_name}".to_sym).new(self, model_name.to_s))
          self.define_singleton_method(method_name.to_sym) do
            instance_variable_get(variable_name)
          end
        end
        instance_variable_get(variable_name)
      end
    end
  end
end
