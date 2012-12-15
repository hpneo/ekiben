module Bentou
  module Models
    module Statusable
      include Base
      extend ActiveSupport::Concern

      included do
        if self.const_defined?(:STATUSES)
          self::STATUSES.keys.each do |status|
            define_method "set_as_#{status}".to_sym do
              self.status = status
              self.save
            end
          end
        end
      end

    end
  end
end