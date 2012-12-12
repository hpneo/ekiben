module Bentou
  module Models
    module Base
      
      def resource_items
        self.send("#{resource_name}_items")
      end

      # "Product" => "product"
      def resource_name
        # TODO: move it to use this regexp /(.*::)?(.*)/
         @resource_name ||= self.class.name.underscore.singularize
      end
      
    end
  end
end
