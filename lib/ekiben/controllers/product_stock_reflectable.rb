module Bentou
  module Controllers
    module ProductStockReflectable

      extend ActiveSupport::Concern
      include Base
      
      included do
        after_filter :update_stock, :only => [:create,:update]
      end

      def update_stock
        resource_instance.update_stocks
      end
      
    end
  end
end
