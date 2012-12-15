require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

module Bentou
  module Models
    module Barcodable
      include Base
      extend ActiveSupport::Concern

      module InstanceMethods
        before_create :create_barcode

        def create_barcode
          barcode = Barby::Code128B.new(self.code)
          filename = File.join(Rails.root, "public/system/barcodes/#{self.id}.png")
          File.open(filename, 'w'){|f| f.write barcode.to_png }

          self.barcode = File.open(filename)
        end
        
      end
    end
  end
end