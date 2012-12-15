module Bentou
  module Models
    module Statusable
      include Base

      module ClassMethods
        if const_defined?("STATUSES")
          STATUSES.keys do |status|
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