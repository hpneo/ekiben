module Bentou
  module Models
    module DateRangeable
      extend ActiveSupport::Concern

      included do
        scope :between?, lambda { |start_date, end_date|
          resource_name = self.name.underscore.singularize
          case resource_name
            when 'shipping_list'
              where("received_at BETWEEN ? AND ?", start_date, end_date)
            when 'send_list'
              where("send_date BETWEEN ? AND ?", start_date, end_date)
            else
              where("#{resource_name}_date BETWEEN ? AND ?", start_date, end_date)
          end
        }
      end
    end
  end
end
