module Bentou
  module Controllers
    module ProductStockUnloadable

      extend ActiveSupport::Concern
      include Base
      
      def update_stock
      	resource_instance.update_stocks if resource_instance.unload_stock?
      end
            
    end
  end
end


