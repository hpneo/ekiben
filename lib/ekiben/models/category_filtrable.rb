module Bentou
  module Models
    module CategoryFiltrable

      include Base

      def shoes
        self.resource_items.select{|i| i.product && i.product.shoe?}
      end

      def not_shoes
        self.resource_items.select{|i| i.product && !i.product.shoe?}
      end

    end
  end
end