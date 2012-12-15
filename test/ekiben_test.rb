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
  end

  context "Order model" do
    def setup
      create_product_model(:openable, :date_rangeable, :product_stock_reflectable, :barcodable, :statusable, :identifiable)
      create_order_model(:openable, :date_rangeable, :product_stock_reflectable, :identifiable, :items_manager)
      create_order_items_model(:discountable)

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
      
      assert @order.order_items.first.class.ancestors.include?(::Bentou::Models::Discountable)
    end
  end
end