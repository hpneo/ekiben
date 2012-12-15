require './test/helper'

class EkibenTest < Test::Unit::TestCase
  context "Product model" do
    def setup
      create_product_model(:openable, :date_rangeable, :product_stock_reflectable, :barcodable, :statusable, :identifiable)
      @product = Product.new
    end

    should "include selected modules" do
      assert @product.class.ancestors.include?(::Bentou::Models::Openable)
      assert @product.class.ancestors.include?(::Bentou::Models::DateRangeable)
      assert @product.class.ancestors.include?(::Bentou::Models::ProductStockReflectable)
      assert @product.class.ancestors.include?(::Bentou::Models::Barcodable)
      assert @product.class.ancestors.include?(::Bentou::Models::Statusable)
      assert @product.class.ancestors.include?(::Bentou::Models::Identifiable)
    end

    should "have Openable methods" do
      assert @product.class.respond_to?(:opened)
      assert @product.class.respond_to?(:closed)
      assert @product.class.respond_to?(:opened_records?)

      assert @product.respond_to?(:set_as_opened)
      assert @product.respond_to?(:set_as_closed)
    end

    should "have DateRangeable methods" do
      assert @product.class.respond_to?(:between?)
    end

    should "have ProductStockReflectable methods" do
      assert @product.respond_to?(:update_stocks)
    end

    should "have Barcodable methods" do
      assert @product.respond_to?(:create_barcode)
    end

    should "have Statusable methods" do
      assert @product.respond_to?(:set_as_locked)
    end

    should "have Identifiable methods" do
      assert @product.respond_to?(:next_identifier)
    end
  end

  context "Order model" do
    def setup
      create_product_model(:openable, :date_rangeable, :product_stock_reflectable, :barcodable, :statusable, :identifiable)
      create_order_model(:openable, :date_rangeable, :product_stock_reflectable, :identifiable, :items_manager)
      create_order_items_model

      @product = Product.new
      @order = Order.new
      @order.order_items.build
    end

    should "include selected modules" do
      assert @order.class.ancestors.include?(::Bentou::Models::Openable)
      assert @order.class.ancestors.include?(::Bentou::Models::DateRangeable)
      assert @order.class.ancestors.include?(::Bentou::Models::ProductStockReflectable)
      assert @order.class.ancestors.include?(::Bentou::Models::Identifiable)
      assert @order.class.ancestors.include?(::Bentou::Models::ItemsManager)
    end
  end
end