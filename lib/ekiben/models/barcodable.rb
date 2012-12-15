require 'barby'
require 'chunky_png'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

module Bentou
  module Models
    module Barcodable
      include Base
      extend ActiveSupport::Concern

      included do
        before_create :create_barcode
      end

      def create_barcode
        barcode = Barby::Code128B.new(self.code)
        filename = File.join(Rails.root, "public/system/barcodes/#{self.id}.png")
        File.open(filename, 'w'){|f| f.write barcode.to_png }

        self.barcode = File.open(filename)
      end
    end
  end
end