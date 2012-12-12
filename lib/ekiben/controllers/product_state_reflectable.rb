module Bentou
  module Controllers
    module ProductStateReflectable

      extend ActiveSupport::Concern
      include Base
      
      included do
        after_filter :close_products, :only => [:create,:update]
        after_filter :open_products, :only => [:edit]
      end

      def close_products
        resource_instance.close_products
      end

      def open_products
        resource_instance.open_products
      end
      
    end
  end
end
