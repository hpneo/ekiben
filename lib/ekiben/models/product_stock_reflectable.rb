module Bentou
  module Models
    module ProductStockReflectable
      extend ActiveSupport::Concern
      include Base

      included do
        after_save :update_stocks
      end

      def update_stocks
        self.reload
        self.transaction do
          self.products.each(&:update_stock_from_resource)
        end
      end

    end
  end
end


