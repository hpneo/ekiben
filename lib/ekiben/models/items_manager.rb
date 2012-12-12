module Bentou
  module Models
    module ItemsManager

      include Base

      def find_items_for_product(product_id)
        self.resource_items.where(:product_id => product_id)
      end

      def total_items
      	self.resource_items.inject(0){|result,item| result + item.quantity}
      end

      def total_cost
      	self.resource_items.inject(0){|result,item| result + item.total_cost}
      end

    end
  end
end
