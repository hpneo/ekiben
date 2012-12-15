require 'ekiben/version'
require 'active_support/inflector'

require 'ekiben/models/base'
require 'ekiben/models/barcodable'
require 'ekiben/models/date_rangeable'
require 'ekiben/models/discountable'
require 'ekiben/models/identifiable'
require 'ekiben/models/items_manager'
require 'ekiben/models/openable'
require 'ekiben/models/product_stock_reflectable'
require 'ekiben/models/statusable'

module Ekiben
  extend ActiveSupport::Concern
  
  module ClassMethods
    def resource_is(args)
      args.each do |module_name|
        include "/bentou/models/#{module_name}".camelize.constantize
      end
    end
  end

  module Initializer
    def self.included(base)
      base.extend ClassMethods
    end
  end

end

ActiveRecord::Base.send(:include, Ekiben::Initializer) if defined?(ActiveRecord)