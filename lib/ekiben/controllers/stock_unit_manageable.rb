module Bentou
  module Controllers   
    module StockUnitManageable

      extend ActiveSupport::Concern
      include Base

      included do
        before_filter :append_to_existing_resource_instance_item, :only => :create
      end

      def append_to_existing_resource_instance_item
        resource_master_instance = resource_master_class.find(params[resource_sym]["#{resource_master_name}_id"])
        resource_instance_item = resource_master_instance.send(resource_name.pluralize).find_by_product_id(params[resource_sym][:product_id])
        if resource_instance_item # == target_instance
          resource_instance_item.merge params[resource_sym]
          resource_instance_item.reload
          create_instance_ival(resource_instance_item)  
          create_master_ival(resource_master_instance)
          render "update_form"
        else
          create_instance_ival(resource_class.new(params[resource_sym]))
        end
      end
      
=begin
	      if @shipping_list_item = ShippingList.find(params[:shipping_list_item][:shipping_list_id]).shipping_list_items.find_by_product_id(params[:shipping_list_item][:product_id])
	        #redirect_to params.merge!(:action => :update, :id => shipping_list_item.id, :method => "put")
	        @shipping_list_item.merge params[:shipping_list_item]
	        @shipping_list_item.reload
	        @shipping_list = @shipping_list_item.shipping_list
	        render "update_form"
        else
          @shipping_list_item = ShippingListItem.new(params[:shipping_list_item])
        end
	    end
=end
    end
  end
end
