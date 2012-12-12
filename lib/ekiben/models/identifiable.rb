module Bentou
  module Models
    module Identifiable
      extend ActiveSupport::Concern

      included do
        after_initialize :setup_identifier
        validates_presence_of :identifier
      end

      def next_identifier
        self.class.last.identifier.next
        #"111"
      end
    
      def setup_identifier
        unless identifier
          self.identifier = (self.class.last ? next_identifier : "000001") 
        end
          #self.identifier ||= self.class.last ? self.class.last.identifier.next : "000001"
      end

    end
  end
end



