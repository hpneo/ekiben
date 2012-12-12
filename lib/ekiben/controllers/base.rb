module Bentou
  module Controllers
    module Base
      
      def resource_instance
        if params[:id]
          @_resource ||= resource_class.find(params[:id])
        else
          @_resource ||= (session[session_name] ? resource_class.find(session[session_name]) : resource_class.create)
        end
      end
      
      def session_name
        "active_#{resource_name}".to_sym
      end
      
      def resource_collection
        @_resource_collection ||= get_ival(resource_collection_name)
      end
      
      #@product
      def create_instance_ival(value)
        create_ival(resource_name,value)
      end

      def create_master_ival(value)
        create_ival(resource_master_name,value)
      end

      def create_instance_items_ival(value)
        create_ival(resource_instance_items_name,value)
      end

      def create_instance_item_ival
        value = resource_item_class.new("#{resource_name}_id".to_sym => resource_instance.id)
        create_ival("new_item", value)
      end

      #@products
      def create_collection_ival(value)
        create_ival(resource_collection_name,value)
      end
      
      def saved_resource_instance?
        resource_instance.errors.empty?
      end
      
      def resource_items
        resource_instance.send("#{resource_name}_items")
      end
      
      def create_ival(name,value)
        ival_name = "@#{name}".to_sym # :@product
        self.instance_variable_set(ival_name,value)        
      end
  
      def get_ival(name)
        ival_name = "@#{name}".to_sym # :@product
        self.instance_variable_get(ival_name)
      end
  
      # "product" => Product
      def resource_class
        resource_name.classify.constantize
      end

      # order_item.order
      def resource_master_instance
        resource_instance.send("#{resource_master_name}")
      end

      # order_item.order.order_items
      def resource_master_instance_items
        resource_master_instance.send("#{resource_name}s")
      end

      # "order"  => Order
      def resource_master_class
        resource_master_name.classify.constantize
      end

      def resource_item_class
        if resource_name.scan("_item").empty?
          "#{resource_name}_item".classify.constantize
        else
          resource_name.classify.constantize
        end
      end
  
      # "ProductsController" => "product"
      def resource_name
        # TODO: move it to use this regexp /(.*::)?(.*)Controller/
         @resource_name ||= self.class.name.gsub("Controller","").gsub("Admin::","").underscore.singularize
      end

      # "order_item" => "order"
      def resource_master_name
        resource_name.gsub("_item", "")
      end
      
      def resource_sym
        resource_name.to_sym
      end

      def resource_instance_items_name
        "#{resource_name}_items"
      end
      
      def resource_collection_name
        @resource_collection ||= resource_name.pluralize
      end
    end
  end
end
