require './test/helper'

class EkibenTest < Test::Unit::TestCase
  context "Produc model" do
    def setup
      create_product_model(:openable, :category_filtrable, :date_rangeable, :product_stock_reflectable, :barcodable, :statusable, :identifiable)
      #create_order_model(:openable, :date_rangeable, :stock_refectable, :identifiable, :paymentable, :partial_paymentable, :items_manager)
      #create_order_items_model(:discountable, :stock_normalizable)
      @product = Product.new
    end

    def teardown
      #drop_table :products
      #drop_table :orders
    end

    should "include selected modules" do
      assert @product.class.ancestors.include?(::Bentou::Models::Openable)
      assert @product.class.ancestors.include?(::Bentou::Models::CategoryFiltrable)
      assert @product.class.ancestors.include?(::Bentou::Models::DateRangeable)
      assert @product.class.ancestors.include?(::Bentou::Models::ProductStockReflectable)
      assert @product.class.ancestors.include?(::Bentou::Models::Barcodable)
      assert @product.class.ancestors.include?(::Bentou::Models::Statusable)
      assert @product.class.ancestors.include?(::Bentou::Models::Identifiable)
    end
  end
end