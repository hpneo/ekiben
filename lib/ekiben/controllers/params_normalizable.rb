module Bentou
  module Controllers
    module ParamsNormalizable
      
      extend ActiveSupport::Concern
      include Base    
      
      included do
    	  before_filter :normalize_params, :only => [:create, :update]
      end
      
      private

  	  def normalize_params
  	   	params[resource_sym][:unit_totals].each do |key, value|
  			  params[resource_sym][:unit_totals][key.to_sym] = value.to_i
    		end
  	  end
    	      
    end
  end
end