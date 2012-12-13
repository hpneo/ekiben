module Bentou
  module Models
    module Discountable

      def set_discount
        self.discount = case self.product_total
              when 0..49 then 0.0
              when 50..149 then 0.15
              when 150..999 then 0.20
              else 0.3
            end
      end

    end
  end
end