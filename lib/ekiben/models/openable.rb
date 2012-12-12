module Bentou
  module Models
    module Openable
      extend ActiveSupport::Concern

      included do
        
        scope :opened, where(:opened => true)
        scope :closed, where(:opened => false)
        
      end

      module ClassMethods
        def opened_count
          self.opened.count
        end
        
        def opened_records?
          self.opened_count > 0
        end
      end
      
      def set_as_closed
        self.opened = false
        self.save
      end
      
      def set_as_opened
        self.opened = true
        self.save      
      end

    end
  end
end