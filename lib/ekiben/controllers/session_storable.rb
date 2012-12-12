module Bentou 
  module Controllers 
    module SessionStorable

      extend ActiveSupport::Concern
      include Base
      
      included do
        before_filter :setup_resource, :only => :new
        after_filter :reset_session_resource_id, :only => [:create, :update]
      end
  
      def setup_resource
        create_instance_ival(resource_instance)
      rescue Exception => ex
        create_instance_ival(resource_class.create)
      ensure
        session[session_name] = resource_instance.id
      end

      def reset_session_resource_id    
        session[session_name] = nil if saved_resource_instance?
      end
    
    end
  end
end