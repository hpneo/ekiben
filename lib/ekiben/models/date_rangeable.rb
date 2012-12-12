module Bentou
  module Models
    module DateRangeable
      extend ActiveSupport::Concern

      module ClassMethods
        def date_range(find, start_date, end_date)
          case find
            when 'all'
              self.where("created_at BETWEEN ? AND ?", start_date, end_date)
            when 'from_web'
              self.where({:from_web => true}).where("created_at BETWEEN ? AND ?", start_date, end_date)
            when 'admin'
              self.where({:from_web => false}).where("created_at BETWEEN ? AND ?", start_date, end_date)
            else
              if self.name.underscore.singularize=='shipping_list'
                self.where("received_at BETWEEN ? AND ?", start_date, end_date)
              elsif self.name.underscore.singularize=='send_list'
                self.where("send_date BETWEEN ? AND ?", start_date, end_date)
              else
                self.where("#{self.name.underscore.singularize}_date BETWEEN ? AND ?", start_date, end_date)
              end
          end
        end
      end
    end
  end
end
