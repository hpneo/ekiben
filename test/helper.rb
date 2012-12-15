require 'rubygems'
require 'active_record'

require 'tempfile'
require 'pathname'

require 'test/unit'
require 'shoulda'
require 'shoulda-context'

ROOT = Pathname(File.expand_path(File.join(File.dirname(__FILE__), '..')))

$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'ekiben')

require File.join(ROOT, 'lib', 'ekiben.rb')

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))

ActiveRecord::Base.establish_connection(config['test'])

def create_class(class_name)
  ActiveRecord::Base.send(:include, Ekiben::Initializer)

  if not class_name.safe_constantize.nil?
    Object.send(:remove_const, class_name)
  end
  
  klass = Object.const_set(class_name, Class.new(ActiveRecord::Base)) 

  klass.class_eval do
    include Ekiben::Initializer
  end

  klass.reset_column_information
  klass.connection_pool.clear_table_cache!(klass.table_name) if klass.connection_pool.respond_to?(:clear_table_cache!)
  klass.connection.schema_cache.clear_table_cache!(klass.table_name) if klass.connection.respond_to?(:schema_cache)
  klass
end

def create_product_model(*modules)
  create_products_table
  create_class("Product").tap do |klass|
    if modules.include?(:statusable)
      klass.const_set('STATUSES', {
        :finished => 'Finished',
        :locked => 'Locked',
        :internal_sale => 'Internal sale only'
      })
    end

    klass.resource_is modules
  end
end

def create_order_model(*modules)
  create_orders_table
  create_class("Order").tap do |klass|
    klass.resource_is modules

    klass.has_many :order_items
  end
end

def create_order_items_model(*modules)
  create_order_items_table
  create_class("OrderItem").tap do |klass|
    klass.resource_is modules

    klass.belongs_to :order
    klass.belongs_to :product
  end
end

def create_products_table
  if !ActiveRecord::Base.connection.table_exists?(:products)
    ActiveRecord::Base.connection.create_table :products, :force => true do |t|
      t.string  :identifier
      t.string  :name
      t.text    :description
    end
  end
end

def create_orders_table
  if !ActiveRecord::Base.connection.table_exists?(:orders)
    ActiveRecord::Base.connection.create_table :orders, :force => true do |t|
      t.string  :identifier
      t.string  :name
      t.date    :order_date, :default => Date.today
      t.decimal :total, :precision => 10, :scale => 2, :default => 0.0
    end
  end
end

def create_order_items_table
  if !ActiveRecord::Base.connection.table_exists?(:order_items)
    ActiveRecord::Base.connection.create_table :order_items, :force => true do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :cost, :precision => 10, :scale => 2, :default => 0.0
    end
  end
end

def drop_table(table_name)
  ActiveRecord::Base.connection.drop_table table_name.to_sym
end