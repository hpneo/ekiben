module Bentou
  module Controllers
    module DetailsLoadable

      extend ActiveSupport::Concern
      include Base

      included do
        before_filter :load_details, :only => [:new, :edit]
      end

      def load_details
        create_instance_items_ival(resource_items)
        create_instance_item_ival
      end

    end
  end
end
