module Bentou
  module Controllers   
    module StatusClosable

      extend ActiveSupport::Concern
      include Base
            
      included do
        before_filter :open_resource, :only => :edit
        after_filter :close_resource, :only => [:create, :update]
      end
      
      def close_resource
      	resource_instance.set_as_closed if saved_resource_instance?
      end
      
      def open_resource
        resource_instance.set_as_opened
      end
      
      def index
        if params[:all]
          create_collection_ival(resource_class.all)
        else
          create_collection_ival(resource_class.closed)
        end
        index!
      end
      
      
    end
    
  end
end